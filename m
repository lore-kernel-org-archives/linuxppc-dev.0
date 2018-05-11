Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hycR3QmQzF2Ct
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 15:01:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alastair D'Silva <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, arnd@arndb.de, linux-doc@vger.kernel.org,
 malat@debian.org, gregkh@linuxfoundation.org, corbet@lwn.net,
 vaibhav@linux.vnet.ibm.com, npiggin@gmail.com, linux-kernel@vger.kernel.org,
 fbarrat@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com, pombredanne@nexb.com, felix@linux.vnet.ibm.com,
 sukadev@linux.vnet.ibm.com, Alastair D'Silva <alastair@d-silva.org>
Subject: Re: [PATCH v3 5/7] ocxl: Expose the thread_id needed for wait on
 POWER9
In-Reply-To: <20180509004212.4506-6-alastair@au1.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180509004212.4506-1-alastair@au1.ibm.com>
 <20180509004212.4506-6-alastair@au1.ibm.com>
Date: Fri, 11 May 2018 15:01:35 +1000
Message-ID: <877eoass40.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Alastair D'Silva" <alastair@au1.ibm.com> writes:
> diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
> index 0af83d80fb3e..8d2748e69c84 100644
> --- a/include/uapi/misc/ocxl.h
> +++ b/include/uapi/misc/ocxl.h
> @@ -48,6 +48,15 @@ struct ocxl_ioctl_metadata {
>  	__u64 reserved[13]; // Total of 16*u64
>  };
>  
> +struct ocxl_ioctl_p9_wait {
> +	__u16 thread_id; // The thread ID required to wake this thread
> +	__u16 reserved1;
> +	__u32 reserved2;
> +	__u64 reserved3[3];
> +};
> +
> +};
> +

O_o

???

cheers
