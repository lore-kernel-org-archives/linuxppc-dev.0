Return-Path: <mgreer@mvista.com>
Date: Mon, 18 Sep 2006 17:48:05 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 1/6] bootwrapper: arch/powerpc/boot code reorg
Message-ID: <20060919004805.GA2018@mag.az.mvista.com>
References: <20060719230014.GB3887@mag.az.mvista.com>
	<20060908033508.GA5203@mag.az.mvista.com>
	<17674.32333.958250.868794@cargo.ozlabs.ibm.com>
	<20060915180129.GE1884@mag.az.mvista.com>
	<17675.30508.252375.59449@cargo.ozlabs.ibm.com>
	<20060919004503.GA920@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060919004503.GA920@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 18, 2006 at 05:45:03PM -0700, Mark A. Greer wrote:

> I should change simple_alloc to _ALIGN_UP only 4K while I'm at it.

Er, nevermind, I'll align to the granularity of the alloc size.  Duh...
