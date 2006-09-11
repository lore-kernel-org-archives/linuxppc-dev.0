Return-Path: <jdl@freescale.com>
Subject: Re: [PATCH 1/1] bootwrapper: add flat device tree support code
From: Jon Loeliger <jdl@freescale.com>
To: Hollis Blanchard <hollis@penguinppc.org>
In-Reply-To: <1158000245.24546.24.camel@basalt.austin.ibm.com>
References: <20060908034623.GG5203@mag.az.mvista.com>
	<1157726787.26967.7.camel@basalt.austin.ibm.com>
	<1157995667.27129.148.camel@cashmere.sps.mot.com>
	<1158000245.24546.24.camel@basalt.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1157999955.27129.168.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Mon, 11 Sep 2006 13:39:15 -0500
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-09-11 at 13:44, Hollis Blanchard wrote:

> That's certainly a good place the new code could be applied. Of course,
> I haven't sent patches to uboot, iseries boot code, kexec, or any other
> number of places either, and don't really plan to. If those areas have
> problems, they can switch to the consolidated codebase then (rather than
> bugfixing the non-consolidated code).

I'm worried about the code-duplication factor here...

> Why, are you going to convert DTC?

I'm not opposed to accepting patches. :-)

jdl
