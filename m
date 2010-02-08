Return-Path: <anton@ozlabs.org>
Date: Mon, 8 Feb 2010 16:43:58 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH] Clear MSR_RI during RTAS calls
Message-ID: <20100208054358.GP32246@kryten>
References: <20100208053729.GO32246@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100208053729.GO32246@kryten>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> The setting of MSR_RI during RTAS calls went in ages ago (2003), and I'm
> not sure why. Clearly an exception inside RTAS is fatal since we most likely
> have a bad r13.

I wrote the r13 comment without thinking :) Regardless I think we want
to catch any RTAS exception ASAP.  

Anton
