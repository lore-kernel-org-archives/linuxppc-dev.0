Message-ID: <20020207155723.63550.qmail@web20102.mail.yahoo.com>
Date: Thu, 7 Feb 2002 07:57:23 -0800 (PST)
From: Bruce <brc1995@yahoo.com>
Subject: Re: Problems running PING, Telnet 
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Murali,

We had similar problems when we moved from an NFS
mounted file system to a RAM Disk.

>> - PING command does not work
>>               The erro message I get is "ping:
unknown protocol icmp"

>>                - Telnet program does not work which
tells me that the service is unknown.
>>               The error message I get is "telnet:
tcp/telnet: unknown service"


You didn't mention whether telnet and ping were
working on the nfs mounted filesystem and
then stopped working when you migrated to
the RAM Disk.

If that is the case, we found the strace tool to
be indispensible. Bring the strace tool over to
your target and execute

strace ping

System calls will be displayed on your terminal. The
program will show if there are failures as it
is trying to open shared libraries or other
configuration files. It is not perfect, but it can
really help to narrow down where the problem
may reside.

Bruce

Send FREE Valentine eCards with Yahoo! Greetings!
http://greetings.yahoo.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
