Return-Path: <dgibson@ozlabs.org>
Date: Wed, 14 May 2008 12:47:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: mpc86xx - couple of questions...
Message-ID: <20080514024724.GB27207@yookeroo.seuss>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D702315472@corpexc01.corp.networkrobots.com>
	<E1Jw6EC-0005sE-3W@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1Jw6EC-0005sE-3W@jdl.com>
Cc: linuxppc-dev@ozlabs.org, Siva Prasad <sprasad@bivio.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 13, 2008 at 08:56:24PM -0500, Jon Loeliger wrote:
> > Hi,
> > 
> > I took the latest tree from linux/kernel/git/galak/powerpc.git
> > (2.6.26-rc2), and the latest dtc from linux/kernel/git/galak/dtc.git.
> 
> Hmm.  galak, good.  Or paulus.  But the latest DTC is
> found on jdl.com still.
> 
> > After compiling, I am having couple of questions.
> > 
> > 1) Doesn't the latest dtc support /memreserve/ on the top before or
> > after /dts-v1/?
> 
> /dts-v1/ is first as it sets the framework for the
> rest of the source file.

Including the format of the /memreserve/ entries themselves.  If
/dts-v1/ appears, it *must* be the first token in the file, anything
else is a syntax error.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
