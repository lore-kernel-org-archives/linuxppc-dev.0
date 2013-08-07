Return-Path: <paulus@ozlabs.org>
Date: Wed, 7 Aug 2013 14:24:55 +1000
From: Paul Mackerras <paulus@samba.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 48/63] powerpc/kvm/book3s_hv: Add little endian guest
 support
Message-ID: <20130807042455.GD31007@iris.ozlabs.ibm.com>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
 <1375804940-22050-49-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375804940-22050-49-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 07, 2013 at 02:02:05AM +1000, Anton Blanchard wrote:
> Add support for the H_SET_MODE hcall so we can select the
> endianness of our exceptions.
> 
> We create a guest MSR from scratch when delivering exceptions in
> a few places and instead of extracting the LPCR[ILE] and inserting
> it into MSR_LE each time simply create a new variable intr_msr which
> contains the entire MSR to use.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Acked-by: Paul Mackerras <paulus@samba.org>
