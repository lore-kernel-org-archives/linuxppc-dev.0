Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E96C4B71AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 May 2011 23:45:06 +1000 (EST)
In-Reply-To: <1305977629-26648-1-git-send-email-dbaryshkov@gmail.com>
References: <1305973871-28244-2-git-send-email-dbaryshkov@gmail.com>
	<1305977629-26648-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <cca27f630fb5e3388eef060ea784f024@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2] cpc925_edac: support single-processor configurations
Date: Sat, 21 May 2011 15:45:41 +0200
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Harry Ciao <qingtao.cao@windriver.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org, Doug Thompson <dougthompson@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> If second CPU is not enabled, CPC925 EDAC driver will spill out 
> warnings
> about errors on second Processor Interface. Support masking that out,
> by detecting at runtime which CPUs are present in device tree.

That doesn't quite work, there can be multiple CPUs per processor 
interface.
You should be able to see which interfaces are enabled in some CPC925 
register,
but maybe both _are_ enabled on your system (although one is not 
connected),
which is causing the errors?


Segher
