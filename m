Return-Path: <jwboyer@linux.vnet.ibm.com>
Subject: Re: [CURIOUSITY] When will we stop caring about arch/ppc?
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20070625182304.GC31840@mag.az.mvista.com>
References: <20070625182304.GC31840@mag.az.mvista.com>
Content-Type: text/plain
Date: Mon, 25 Jun 2007 13:40:00 -0500
Message-Id: <1182796800.23775.51.camel@weaponx.rchland.ibm.com>
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

On Mon, 2007-06-25 at 11:23 -0700, Mark A. Greer wrote:
> Any opinions on when we stop worrying about arch/ppc and start getting
> rid of it for real?

There are lots of boards in the 4xx family that don't exist yet in
powerpc.  I don't think we want it to die until they get moved over, or
at least marked as in a "danger zone" for a while.

Maybe what we could do is designate a kernel release where we'll stop
taking new arch/ppc submissions?

josh
