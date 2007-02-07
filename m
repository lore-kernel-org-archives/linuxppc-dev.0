Return-Path: <arnd.bergmann@de.ibm.com>
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/3] spufs: don't need struct page for SPEs
Date: Wed, 7 Feb 2007 15:39:23 +0100
References: <1170823850.450936.293648942401.qpush@grosgo>
In-Reply-To: <1170823850.450936.293648942401.qpush@grosgo>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702071539.23556.arnd.bergmann@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 07 February 2007 05:50, Benjamin Herrenschmidt wrote:
> I have no firm feeling on wether those should be in 2.6.21 or not,
> they are pre-requisite for some other work I'm doing with spufs but
> which won't be in 2.6.21 (well, I don't think it will be ready in time
> and it doesn't really matter) so I'm mostly posting this here for
> review/comment/backup :-) I would appreciate testing too, I did some
> tests here and they seem to pass but heh, the more the better.

I'd say they should go in. The code is clearly moving things into
the right direction. In fact, we have recently discovered a bug
in the SPU management that might be fixed by just applying your
patch, but that still needs to be investigated.

	Arnd <><
