Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 13FBAB6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Jun 2010 04:58:34 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
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
	<m3mxvfrt5n.fsf__49359.5060579993$1275385036$gmane$org@hase.home>
Date: Tue, 01 Jun 2010 20:58:27 +0200
In-Reply-To: <m3mxvfrt5n.fsf__49359.5060579993$1275385036$gmane$org@hase.home>
	(Andreas Schwab's message of "Tue, 01 Jun 2010 11:36:36 +0200")
Message-ID: <m2wruiy3zg.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andreas Schwab <schwab@redhat.com> writes:

> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>
>> On Mon, 2010-05-31 at 20:06 +0200, Andreas Schwab wrote:
>>> Alexander Graf <agraf@suse.de> writes:
>>> 
>>> > Mind to send it over so I can take a look at it :)? Getting rid of the
>>> > task_struct structs lying in the stack is certainly a good idea.
>>> 
>>> Still untested, because rc1 does not boot.
>>
>> Ouch ! What machine ?
>
> It's crashing in macio_pci_add_devices.

And snd-aoa is broken, too.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
