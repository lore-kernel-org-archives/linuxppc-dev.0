Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17987.47155.935764.878634@cargo.ozlabs.ibm.com>
Date: Fri, 11 May 2007 10:26:27 +1000
From: Paul Mackerras <paulus@samba.org>
To: olof@lixom.net (Olof Johansson)
Subject: Re: arch/powerpc/sysdev: dumping ground or only for shared drivers?
In-Reply-To: <20070510215730.GA25075@lixom.net>
References: <20070510200237.GA19756@mag.az.mvista.com>
	<20070510215730.GA25075@lixom.net>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson writes:

> This adds yet another set of chipset drivers under sysdev, that are
> only used by one platform (several board ports under that platform,
> but only one platforms/* directory).
> 
> In my opinion, they really should go under the platform directory instead,
> and not clutter the shared directory.

I disagree, actually.  Having these things in a shared directory makes
it more likely that people will look at the code.  That means that
it's more likely that bugs will be found, and more likely that parts
of the code can get reused when people are doing the port to a new
chip or board.

If there were hundreds of files in arch/powerpc/sysdev then I would be
more likely to agree with you, but there aren't.

Paul.
