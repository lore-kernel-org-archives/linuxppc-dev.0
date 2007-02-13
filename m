Return-Path: <krafft@de.ibm.com>
Date: Tue, 13 Feb 2007 19:44:36 +0100
From: Christian Krafft <krafft@de.ibm.com>
To: Christian Krafft <krafft@de.ibm.com>
Subject: Re: [Cbe-oss-dev] [patch v3] pmi: initial version
Message-ID: <20070213194436.0306d18a@localhost>
In-Reply-To: <20070213143418.06fa01b5@localhost>
References: <20070209183529.67d542d5@localhost>
	<20070209184530.4c8bc2be@localhost>
	<20070209222956.GH1827@localdomain>
	<20070212101222.24abe14c@localhost>
	<20070213143418.06fa01b5@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

sorry for resending this patch again.
I added a work queue to the interrupt handler to shorten the time we run with interrupts off.

Cheers,
ck
