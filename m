From: Arun Dharankar <ADharankar@attbi.com>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: lwIP on PPCBoot
Date: Tue, 15 Apr 2003 18:21:25 -0400
Cc: linuxppc-embedded@lists.linuxppc.org
References: <20030415211405.AE0C2C58B9@atlas.denx.de>
In-Reply-To: <20030415211405.AE0C2C58B9@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304151821.25656.ADharankar@ATTBI.Com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Wolfgang, thanks for your kind reply.

On Tuesday 15 April 2003 05:14 pm, you wrote:
> In message <200304151621.55214.ADharankar@ATTBI.Com> you wrote:
> > Anyone ported lwIP (http://www.sics.se/~adam/lwip/
> > or http://savannah.nongnu.org/projects/lwip/) to PPCBoot?
> > I am exploring ideas to use this on PPCBoot/U-Boot.
>
> What for? U-Boot is  a  boot  loader.  You  don't  need  things  like
> multi-tasking or a ful TCP/IP stack or java support in a boot loader.
> If  your applications needs such services, then use U-Boot to boot an
> OS. I recommend to use tools for the  purpose  for  which  they  were
> designed  for. Yes, you can use a microscope as a hammer, but I don't
> think it's a good idea. YMMV.

I am sure many will agree that PPCBoot/U-Boot can be used (and
probably IS used by many) for more than booting a bigger/more
sophisticated OSs. Surely, one example is diags.


PPCBoot/U-Boot supports the concept of applications (not linked into
it, but one using system calls). One possible use could be to do some
basic/minimal diags, and send an SNMP trap for any failed diags.
Surely, the stack could be linked into PPCBoot/U-Boot application
without having to modify PPCBoot/U-Boot. Maybe some change to
expose the network interface via system calls would be needed.

By the way, being able to access ethernet interfaces via system calls
seems to be something very useful to have. Ethernet diags at application
level could use it effectively. Anything already done for this?


You might agree: it depends on how much creative one can get. I am
quite sure that others will be more creative with what else can be
implemented using PPCBoot/U-Boot. I agree 100% with what you
wrote: YMMV.


Best regards,
-Arun.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
