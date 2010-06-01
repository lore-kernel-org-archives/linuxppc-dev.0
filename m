Return-Path: <schwab@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 09B0CB7D1D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Jun 2010 19:36:42 +1000 (EST)
From: Andreas Schwab <schwab@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Don't export cvt_fd & _df when CONFIG_PPC_FPU is
	not set
References: <1275270628.1931.540.camel@pasglop>
	<1275271231.1931.547.camel@pasglop>
	<FAE73713-EE73-4FA6-B1C6-88D38E230F01@suse.de>
	<m3ljb0tn2l.fsf@hase.home>
	<4C03DB3D.7090007__38063.9078132392$1275321190$gmane$org@suse.de>
	<m2aargndy2.fsf@igel.home>
	<1275384716.1931.711.camel__10281.3212587082$1275384770$gmane$org@pasglop>
Date: Tue, 01 Jun 2010 11:36:36 +0200
In-Reply-To: <1275384716.1931.711.camel__10281.3212587082$1275384770$gmane$org@pasglop>
	(Benjamin Herrenschmidt's message of "Tue, 01 Jun 2010 19:31:56
	+1000")
Message-ID: <m3mxvfrt5n.fsf@hase.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Mon, 2010-05-31 at 20:06 +0200, Andreas Schwab wrote:
>> Alexander Graf <agraf@suse.de> writes:
>> 
>> > Mind to send it over so I can take a look at it :)? Getting rid of the
>> > task_struct structs lying in the stack is certainly a good idea.
>> 
>> Still untested, because rc1 does not boot.
>
> Ouch ! What machine ?

It's crashing in macio_pci_add_devices.

Andreas.

-- 
Andreas Schwab, schwab@redhat.com
GPG Key fingerprint = D4E8 DBE3 3813 BB5D FA84  5EC7 45C6 250E 6F00 984E
"And now for something completely different."
