import { createLogger, format, transports } from 'winston'
import 'winston-daily-rotate-file'
import { inspect } from 'util'
// import safeStringify from 'fast-safe-stringify'

export default createLogger({
  level: 'debug',
  // format: format.combine(format.splat(), format.simple()),
  format: format.combine(
    format.timestamp({
      format: 'DD.MM.YY HH:mm:ss',
    }),
    format.json(),
    {
      transform(info) {
        const { timestamp, message, durationMs } = info
        const level = info[Symbol.for('level') as unknown as string].toUpperCase()
        // Join the args back into one array
        const args = [message, ...(info[Symbol.for('splat') as unknown as string] || [])]
        // For all custom transports (mainly the console ones)
        info.message = args
        // Message
        let msg = args
          .map(e => {
            if (e.toString() == '[object FileList]') return inspect(e.toArray(), true, 10)
            else if (e.toString() == '[object File]') return inspect(e.toObject(), true, 10)
            else if (e.toString() == '[object Object]') {
              return inspect(e, true, 5)
            } else if (e instanceof Error) return e.stack
            else return e
          })
          .join(' ')
        // For inbuild transport / file-transport
        info[Symbol.for('message') as unknown as string] = `${timestamp} ${level}: ${msg} ${
          durationMs ? `duration: ${durationMs}ms` : ''
        }`
        // Return
        return info
      },
    }
  ),
  transports: [
    // Console
    //new transports.Console({}),
    // Errors
    new transports.DailyRotateFile({
      level: 'warn',
      dirname: 'log',
      filename: 'tpm-error-%DATE%.log',
      datePattern: 'YYMMDD',
      zippedArchive: true,
      createSymlink: true,
      symlinkName: 'error.log',
    }),
    // Combined
    new transports.DailyRotateFile({
      dirname: 'log',
      filename: 'tpm-%DATE%.log',
      datePattern: 'YYMMDD',
      zippedArchive: true,
      createSymlink: true,
    }),
  ],
})
