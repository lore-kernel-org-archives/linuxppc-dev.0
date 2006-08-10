Return-Path: <bwarren@qstreams.com>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by ozlabs.org (Postfix) with SMTP id 8588567B76
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 06:53:56 +1000 (EST)
Subject: RE: Debugging with no serial port
From: Ben Warren <bwarren@qstreams.com>
To: "Martin, Tim" <tim.martin@viasat.com>
In-Reply-To: <821B2170E9E7F04FA38DF7EC21DE487105FD14A0@VCAEXCH01.hq.corp.viasat.com>
References: <821B2170E9E7F04FA38DF7EC21DE487105FD14A0@VCAEXCH01.hq.corp.viasat.com>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 16:53:53 -0400
Message-Id: <1155243233.920.34.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Martin,

On Thu, 2006-08-10 at 13:12 -0700, Martin, Tim wrote:

> 	
> I tried this as well and have the same GDB synchronization problem e.g.
> 
> break log_stuff
> commands
>    silent
>    if (variable_logging_enabled)
>       printf "(%d,%d)\n",stuff1_variable,stuff2_variable
>    end
>    cont
> end
> 
That's too bad.  I wonder if you could run gdb from expect or some other
auto-scripting language and have it issue the 'cont' once all data is
printed (Have your code spit out a special 'end of data' delimiter). 

Just a thought - no idea if it would work.  

I'm not 100% certain how BDI-2000/gdb works, but I guess the gdb server
is running on the box, in which case you probably don't have much
control over how it works, and thus can't control if the output stream
is buffered or not.  My BDI-2000 book doesn't have much on configuring
the gdb part.

Anyway, sorry for rambling.

regards,
Ben
