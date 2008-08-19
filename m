Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/spufs: Remove invalid semicolon after if statement
Date: Tue, 19 Aug 2008 22:44:54 +0800
References: <Pine.LNX.4.64.0808190845570.4551@wrl-59.cs.helsinki.fi>
In-Reply-To: <Pine.LNX.4.64.0808190845570.4551@wrl-59.cs.helsinki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Message-Id: <200808192244.54995.jk@ozlabs.org>
Cc: Ilpo =?iso-8859-1?q?J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>,
	paulus@samba.org, Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ilpo,

> -		if (new_state == SPU_UTIL_USER);
> +		if (new_state == SPU_UTIL_USER)

Thanks, good catch. applied to spufs.git.


Jeremy
