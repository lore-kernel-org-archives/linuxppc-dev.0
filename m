Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 43F9D474C9
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 07:59:02 +1100 (EST)
Message-Id: <F0A77DF4-ECC1-4825-B152-09872E83BD57@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <0F214C64-7F77-4A5B-9937-0E6D7941AAEC@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Booting 2.6.29-rc3 on mpc8661d_hpcn failing
Date: Tue, 10 Feb 2009 14:58:51 -0600
References: <4982F311.4050507@gefanuc.com>
	<F764D461-8EFB-4B31-ABFC-ECBB7A3FBA01@kernel.crashing.org>
	<9B0CCADB-C891-42B2-BE94-0927B5715A00@kernel.crashing.org>
	<4986BEB9.3030606@gefanuc.com>
	<E00697F4-1313-49C2-9F8A-79FC9E511022@kernel.crashing.org>
	<498718B6.3030307@gefanuc.com>
	<D06DAB0F-1477-4CA6-A06D-0F7B62939C86@kernel.crashing.org>
	<49871D3E.80809@gefanuc.com> <1233607753.18767.103.camel@pasglop>
	<49883719.9030300@gefanuc.com> <498867C0.2000607@gefanuc.com>
	<1233708479.16867.129.camel@pasglop>
	<1233750122.23240.11.camel@ubuntu8041.localdomain>
	<0F214C64-7F77-4A5B-9937-0E6D7941AAEC@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've posted a patch that I believe should fix your issue.

- k
