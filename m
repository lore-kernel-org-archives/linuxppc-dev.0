Message-ID: <3FD69C13.5090107@vinesystech.com>
Date: Tue, 09 Dec 2003 20:07:47 -0800
From: Xiaoshan Zuo <xzuo@vinesystech.com>
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>
Cc: zjzhou@newrocktech.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Which program can re-launch my application when this application
 exit for exception?
References: <000801c3bd55$5a1dd440$b702a8c0@newrock2> <3FD41F48.3030000@kegel.com>
In-Reply-To: <3FD41F48.3030000@kegel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


daemontool is one (http://cr.yp.to/djb.html), but it doesn't start
application in order.

Xiaoshan

Dan Kegel wrote:

>
> John Zhou wrote:
>
>> Which program can re-launch my application when this application exit
>> for exception or error?
>
>
> Your own.  It's pretty easy to write a shell script to do this.
> Or you can use initd to do the same thing; see 'man inittab'.
>
> Your questions seem to be fairly generic, not related to
> the ppc; you might want to try asking
> this kind of question on, say,
> http://groups.google.com/groups?group=comp.os.linux.embedded
> or http://www.embeddedtux.org/pipermail/etux/
> - Dan
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
