Return-Path: <rdunlap@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xv37G4q7wzDrVq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 03:59:06 +1000 (AEST)
Subject: Re: [PATCH 6/6] Documentation/admin-guide: single quotes in kernel
 arguments.
To: Michal Suchanek <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Jani Nikula <jani.nikula@intel.com>,
 Kamlakant Patel <kamlakant.patel@broadcom.com>,
 Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>,
 Tamara Diaconita <diaconitatamara@gmail.com>,
 Trond Myklebust <trond.myklebust@primarydata.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nicholas Piggin <npiggin@gmail.com>, Baoquan He <bhe@redhat.com>,
 Ilya Matveychikov <matvejchikov@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <28da60231eb848981e858fa33e3b7e33f8547111.1505494668.git.msuchanek@suse.de>
 <44dd719f756a9e1b8388730b0b4562507027d35a.1505494668.git.msuchanek@suse.de>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <95aef744-2f5f-31ad-a05b-7173d840ef47@infradead.org>
Date: Fri, 15 Sep 2017 10:59:00 -0700
MIME-Version: 1.0
In-Reply-To: <44dd719f756a9e1b8388730b0b4562507027d35a.1505494668.git.msuchanek@suse.de>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/15/17 10:02, Michal Suchanek wrote:
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  Documentation/admin-guide/kernel-parameters.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
> index 722d3f771924..1f9837266417 100644
> --- a/Documentation/admin-guide/kernel-parameters.rst
> +++ b/Documentation/admin-guide/kernel-parameters.rst
> @@ -35,9 +35,10 @@ can also be entered as::
>  
>  	log-buf-len=1M print_fatal_signals=1
>  
> -Double-quotes and backslashes can be used to protect spaces in values, e.g.::
> +Double-quotes single-quaotes and backslashes can be used to protect spaces

                 single-quotes

> +in values, e.g.::
>  
> -	param="spaces in here" param2=spaces\ in\ here
> +	param="spaces in here" param2=spaces\ in\ here param3='@%# !\'
>  
>  cpu lists:
>  ----------
> 


-- 
~Randy
