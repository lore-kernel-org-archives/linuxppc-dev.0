Subject: Re: [PATCH] 2.6 timebase synchronization
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Samuel Rydh <samuel@ibrium.se>
Cc: linuxppc-dev@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
In-Reply-To: <20030809011305.GA12030@ibrium.se>
References: <20030808001523.GA9274@ibrium.se>
	 <20030809011305.GA12030@ibrium.se>
Content-Type: text/plain
Message-Id: <1060419490.653.18.camel@gaston>
Mime-Version: 1.0
Date: 09 Aug 2003 10:58:11 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2003-08-09 at 03:13, Samuel Rydh wrote:
> On Fri, Aug 08, 2003 at 02:15:23AM +0200, Samuel Rydh wrote:
> >
> > Hi,
> >
> > Here is a patch that provides improved generic SMP timebase
> > synchronization for 2.6.
> >
>
> Attached is an improved version of the patch.

I'm on vacation now, I can't test it until I'm back, but that
looks quite good overall (except maybe the MacOS-like constant
naming for kXXXX :)

However, does it work with more than 2 CPUs ? It seem to be rather
dual CPU centric from my understanding of the ack mecanism... The TB sync
code is also used on 4 CPU daystar machines and possibly some other chrp
with more than 2 CPUs.

Paul, any comment ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
