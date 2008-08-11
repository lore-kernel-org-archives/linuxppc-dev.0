Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] please pull cell merge branch
Date: Mon, 11 Aug 2008 09:18:56 +0200
References: <1217620879.15667.145.camel@carll-linux-desktop>
	<200808091513.05251.arnd@arndb.de>
	<18591.30474.127939.243247@cargo.ozlabs.ibm.com>
In-Reply-To: <18591.30474.127939.243247@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808110918.57293.arnd@arndb.de>
Cc: Robert Richter <robert.richter@amd.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, oprofile-list@lists.sf.net,
	Paul Mackerras <paulus@samba.org>, cel <cel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 11 August 2008, Paul Mackerras wrote:
> Arnd Bergmann writes:
> > I've fixed one last bug in Carl's update for cell-oprofile (int flags
> > instead of unsigned long flags) and made sure the comments fit the
> > usual style. This fixes a long-standing bug that prevented us from
> > using oprofile on SPUs in many real-world scenarios.=20
>
> Since you're touching generic oprofile code here, do you have an ack=20
> from the oprofile maintainer? =A0Or is the oprofile maintainer listed in
> MAINTAINERS (Robert Richter) no longer active or something?
>=20

Sorry about that. I had assumed that at the very least Carl had had
the oprofile list on Cc and that people there just didn't care.

Robert has just recently taken over maintainership for oprofile,
so I assume that he is indeed active and interested in the patches.
I'll send them out again for his review on oprofile-list.

	Arnd <><
