Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17571.28082.924898.589734@cargo.ozlabs.ibm.com>
Date: Thu, 29 Jun 2006 16:05:38 +1000
From: Paul Mackerras <paulus@samba.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Subject: RE: patches applied to powerpc.git
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306DD16AC@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD467306DD16AC@zch01exm40.ap.freescale.net>
Cc: linuxppc-dev@ozlabs.org, linux-kernel-owner@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Zang Roy-r61911 writes:

> 	I have submitted the "v2" version for mpc7448hpc2 board support in arch/powerpc/platforms/embedded6xx.
> 	I  have not got any suggestion, since I submitted the code.
> 	In this submission I have addressed all the issues brought up in the "v1" submission. 
> 	So could you help me merge the patches into your git tree ? If there is any comment about the code, please let me know.

I have taken 1, 2, and 4.  Ben H asked me to delay with patch 3/4
because it will conflict with changes he is making.  Also I would like
to see it done in a fashion which doesn't add two extra loads to
things like _mpic_ipi_read etc.

Paul.
