Return-Path: <darenh@4bridgeworks.com>
Received: from ntserver4.diluk.co.uk (mailhost.digitalinterfacesltd.com
	[62.69.87.37]) by ozlabs.org (Postfix) with ESMTP id EF0EE2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Oct 2004 16:13:29 +1000 (EST)
Message-ID: <C18BA5DDB58DD511BD0700C0DF0DD4502941EC@NTSERVER4>
From: Daren Hayward <darenh@4bridgeworks.com>
To: 'Eugene Surovegin' <ebs@ebshome.net>,
	Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
Date: Fri, 22 Oct 2004 06:57:53 +0100
MIME-Version: 1.0
Content-Type: text/plain
Cc: Linux PPC Embedded <linuxppc-embedded@ozlabs.org>
Subject: RE: [BUG] IBM440GX works too slow under nfsroot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

What revision of the CPU do you have?? I know that upto rev C half duplex
has a problem with the cpu and only REV C silicon works if I am not
mistaken, there is an errata on IBM's website about this

Daren

-----Original Message-----
From: Eugene Surovegin [mailto:ebs@ebshome.net]
Sent: 22 October 2004 03:02
To: Hiroshi DOYU
Cc: Linux PPC Embedded
Subject: Re: [BUG] IBM440GX works too slow under nfsroot


On Fri, Oct 22, 2004 at 10:38:59AM +0900, Hiroshi DOYU wrote:
> On Thu, 21 Oct 2004 18:33:20 -0700
> Eugene Surovegin <ebs@ebshome.net> wrote:
> 
> > On Fri, Oct 22, 2004 at 08:57:33AM +0900, Hiroshi DOYU wrote:
> > > Now I am strugging with booting vanilla(2.4.2x) on ibm440gx and
> > > I could succeed to boot it but, after nfs mounted, it's behavior 
> > > seems too slow. I guess, it looks like the system is running 
> > > half duplex. 
> > 
> > Yeah, driver thinks it's connected to 10Mb hub. How the board is 
> > actualy connected to the network?
> 
> 10Mb hub.
> 

Wow, I really had to spend some time to find such ancient hw :). I'll 
try 2.4.27 with this hub during next couple of days (I'm a little busy 
right now) and let you know. I suspect nobody really tested EMAC driver 
in 10Mb HDX mode.

You can also bug Matt Porter, maybe he'll help you sooner :).

--
Eugene
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
