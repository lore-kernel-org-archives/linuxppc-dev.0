Return-Path: <hollis@penguinppc.org>
Subject: Re: [PATCH 1/1] bootwrapper: add flat device tree support code
From: Hollis Blanchard <hollis@penguinppc.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1157999955.27129.168.camel@cashmere.sps.mot.com>
References: <20060908034623.GG5203@mag.az.mvista.com>
	<1157726787.26967.7.camel@basalt.austin.ibm.com>
	<1157995667.27129.148.camel@cashmere.sps.mot.com>
	<1158000245.24546.24.camel@basalt.austin.ibm.com>
	<1157999955.27129.168.camel@cashmere.sps.mot.com>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 14:01:11 -0500
Message-Id: <1158001271.24546.28.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-09-11 at 13:39 -0500, Jon Loeliger wrote:
> On Mon, 2006-09-11 at 13:44, Hollis Blanchard wrote:
> 
> > That's certainly a good place the new code could be applied. Of course,
> > I haven't sent patches to uboot, iseries boot code, kexec, or any other
> > number of places either, and don't really plan to. If those areas have
> > problems, they can switch to the consolidated codebase then (rather than
> > bugfixing the non-consolidated code).
> 
> I'm worried about the code-duplication factor here...

The functionality has already been duplicated, and more was on the way.
The consolidated code prevents that from spreading, but by itself
doesn't replace any of the existing duplication.

> > Why, are you going to convert DTC?
> 
> I'm not opposed to accepting patches. :-)

Have fun.

-Hollis
