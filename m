Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org,
 maynardj@us.ibm.com
Subject: Re: [RFC,
	PATCH 0/4] Add support to OProfile for profiling Cell BE SPUs --
	update
Date: Tue, 30 Jan 2007 09:37:07 +0100
References: <45BE4ED0.5030808@us.ibm.com>
In-Reply-To: <45BE4ED0.5030808@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701300937.07335.arnd@arndb.de>
Cc: cbe-oss-dev@ozlabs.org, oprofile-list@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 29 January 2007 20:45, Maynard Johnson wrote:
> On December 14, 2006, I posted a patch that added support to the=20
> OProfile kernel driver for profiling Cell SPUs. =A0There have been some=20
> changes/fixes to this patch since the original posting (including=20
> forward porting from 2.6.18-based kernel to 2.6.20-rc1), so I am=20
> reposting the patch for review now. =A0This patch relies upon the=20
> following patches that have not been accepted yet:
> =A0 =A01. oprofile cleanup patch (submitted on Nov 27)
> =A0 =A02. Fix for PPU profiling (not submitted yet, since it depends on #=
1)
> =A0 =A03. SPU task notification patch (last submitted on Jan 26)
>=20

Sorry for taking so much time before reviewing this. I knew it would
be a long patch that requires time to go through in detail (though
certainly not nearly as much time as it took you to write it), so I
kept procrastinating.

	Arnd <><
