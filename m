Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 8D21EB7D5E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Jun 2010 04:52:06 +1000 (EST)
Message-ID: <4C040551.1090601@suse.de>
Date: Mon, 31 May 2010 20:52:01 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] powerpc: Don't export cvt_fd & _df when CONFIG_PPC_FPU
	is not set
References: <1275270628.1931.540.camel@pasglop>	<1275271231.1931.547.camel@pasglop>	<FAE73713-EE73-4FA6-B1C6-88D38E230F01@suse.de>	<m3ljb0tn2l.fsf@hase.home>	<4C03DB3D.7090007__38063.9078132392$1275321190$gmane$org@suse.de>
	<m2aargndy2.fsf@igel.home>
In-Reply-To: <m2aargndy2.fsf@igel.home>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andreas Schwab wrote:
> Alexander Graf <agraf@suse.de> writes:
>
>   
>> Mind to send it over so I can take a look at it :)? Getting rid of the
>> task_struct structs lying in the stack is certainly a good idea.
>>     
>
> Still untested, because rc1 does not boot.
>   

Normal guests work great with the patch and from a quick look over it,
it seems sane. I couldn't test the paired single implementation yet,
because my userspace app for that is in a flux right now.

Either way, thanks a lot for the patch. Mind to wrap it up and submit
it? I'll fix breakages later on. Please CC kvm-ppc@vger.kernel.org and
kvm@vger.kernel.org, so Avi or Marcelo can pick it up on the KVM tree.

Alex
