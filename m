Return-Path: <anton@samba.org>
Date: Wed, 23 Apr 2014 07:34:27 +1000
From: Anton Blanchard <anton@samba.org>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/6] powerpc/powernv: Create OPAL sglist helper
 functions and fix endian issues
Message-ID: <20140423073427.425ed7d1@kryten>
In-Reply-To: <5356335A.1080704@linux.vnet.ibm.com>
References: <1398142887-24109-1-git-send-email-anton@samba.org>
 <1398142887-24109-5-git-send-email-anton@samba.org>
 <5356335A.1080704@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: stewart@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> Shouldn't we convert addr and id before passing to opal_dump_read()
> here ?

int64_t opal_dump_read(uint32_t dump_id, uint64_t buffer);

All arguments are passed via register, so byteswaping the arguments
would break it.

Anton
