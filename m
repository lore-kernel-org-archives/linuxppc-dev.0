Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070410111324.GA2957@localhost.localdomain>
References: <20070410111324.GA2957@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <16327e0d9602022d7ee57670ac23c383@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 1/3] powerpc: delete -mstring option
Date: Tue, 10 Apr 2007 14:47:38 +0200
To: Akinobu Mita <mita@fixstars.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> There is no reason to force -mstring option.
> (Kumar, please see patch 2/3 for FSL_BOOKE temporary fix)

> -ifndef CONFIG_FSL_BOOKE
> -CFLAGS		+= -mstring
> -endif

[and from 2/3]

> +ifeq ($(CONFIG_FSL_BOOKE),y)
> +CFLAGS         += -mno-string
> +endif

This is the right solution, thank you for the patch.
But please fold these two together so that you're not
introducing a regression halfway the patch series.


Segher
