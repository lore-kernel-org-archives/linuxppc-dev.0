Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org,
 maynardj@us.ibm.com
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH 1/4] Add support to OProfile for profiling Cell BE SPUs --
	update
Date: Tue, 30 Jan 2007 05:07:46 +0100
References: <45BE4ED0.5030808@us.ibm.com> <45BE4F2A.5040702@us.ibm.com>
In-Reply-To: <45BE4F2A.5040702@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200701300507.47068.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	oprofile-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 29 January 2007 20:46, Maynard Johnson wrote:
>   This is a clean up patch that includes the following changes:
>=20
> =A0 =A0 =A0 =A0 -It removes some macro definitions that are only used once
> =A0 =A0 =A0 =A0 =A0with the actual code.
> =A0 =A0 =A0 =A0 -Some comments were added to clarify the code based on fe=
edback
> =A0 =A0 =A0 =A0 =A0from the community.
> =A0 =A0 =A0 =A0 -The write_pm_cntrl() and set_count_mode() were passed a =
structure
> =A0 =A0 =A0 =A0 =A0element from a global variable. =A0The argument was re=
moved so the
> =A0 =A0 =A0 =A0 =A0functions now just operate on the global directly.
> =A0 =A0 =A0 =A0 -The set_pm_event() function call in the cell_virtual_cnt=
r() routine
> =A0 =A0 =A0 =A0 =A0was moved to a for-loop before the for_each_cpu loop
>=20
> Signed-off-by: Carl Love <carll@us.ibm.com>
> Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com>
>=20

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Just a small side note: Please give each of your patches a one-line
summary in the subject of the email. I'm filing this one under:
"cell: oprofile cleanup".

It would also be good if you could use a mailer that sends out
patches as inline, so you don't need to resort to using attachments.

	Arnd <><
