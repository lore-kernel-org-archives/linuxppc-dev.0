From: James Petterson <jpetterson@PARKS.com.br>
Reply-To: James Petterson <jpetterson@PARKS.com.br>
To: Rod Boyce <rod_boyce@DMCWave.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Subject: Re: Redirecting printk to a file
Date: Wed, 1 Aug 2001 10:30:17 -0300
References: <9DCCE20055ACD311BBE200104B08D8340127490D@EXCHWENZ01> <3B674930.EAD7ED1C@mvista.com>
In-Reply-To: <3B674930.EAD7ED1C@mvista.com>
MIME-Version: 1.0
Message-Id: <01080110301702.01194@james.parks.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tuesday 31 July 2001 21:11, Dan Malek wrote:
> Rod Boyce wrote:
> > We are having a bit of a quandary we are trying to redirect the output of
> > printk
>
> Don't assign a system console, or bump the loglevel real high.
> Then just use the syslog daemon to move it from the kernel circular
> buffer to a file.  This is all standard Linux stuff.
>
> 	-- Dan
For debugging purposes, there's another option that I've found easier to
setup:

1. Set the loglevel to a high priority
echo 1 > /proc/sys/kernel/printk

2. Open a telnet session to your board and, in the opened session:
cat /proc/kmsg

James

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
