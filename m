Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH] Fix sparsemem on Cell
Date: Tue, 19 Dec 2006 09:59:45 +0100
References: <20061215165335.61D9F775@localhost.localdomain>
	<200612182354.47685.arnd@arndb.de>
	<1166483780.8648.26.camel@localhost.localdomain>
In-Reply-To: <1166483780.8648.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200612190959.47344.arnd@arndb.de>
Cc: Andrew Morton <akpm@osdl.org>, mkravetz@us.ibm.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, hch@infradead.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, kmannth@us.ibm.com,
	gone@us.ibm.com, cbe-oss-dev@ozlabs.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 19 December 2006 00:16, Dave Hansen wrote:
> How about an enum, or a pair of #defines?
>=20
> enum context
> {
> =A0 =A0 =A0 =A0 EARLY,
> =A0 =A0 =A0 =A0 HOTPLUG
> };

Sounds good, but since this is in a global header file, it needs
to be in an appropriate name space, like

enum memmap_context {
	MEMMAP_EARLY,
	MEMMAP_HOTPLUG,
};

	Arnd <><
