To: "OTAVIO ISAMU SUGENO" <otavio.sugeno@siemens.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: CPU performance measurement 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 22 Jul 2002 15:30:34 -0300."
             <B7AC573479F05C438F232539B961A168095005@CUR1006V.br002.siemens.net.br>
Date: Mon, 22 Jul 2002 20:49:49 +0200
Message-Id: <20020722184954.45C0410874@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <B7AC573479F05C438F232539B961A168095005@CUR1006V.br002.siemens.net.br> you wrote:
>
> >>Why don't you simply run "top" on your board, then?
> I tried to run "top" on my custom board, but no success. No message
> appears on console. Do I need to do anything special, any configuration?

You did mount the /proc filesystem, didn't you?

> >>Or read /proc/stat?
> I will try this. What kind of information can get from /proc/stat? Is it
> any kind of statistics?

Yes, kernel statistics:
user, nice, system, jiffies * #_cpus - (user + nice + system)

See fs/proc/kstat_read_proc/proc_misc.c

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
When all is said and done, more is said than done.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
