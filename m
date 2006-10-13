Return-Path: <anton@ozlabs.org>
Date: Sat, 14 Oct 2006 07:34:23 +1000
From: Anton Blanchard <anton@samba.org>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
Message-ID: <20061013213423.GG16029@krispykreme>
References: <1160764895.11239.14.camel@farscape>
	<Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
	<1160769226.11239.22.camel@farscape>
	<1160773040.11239.28.camel@farscape>
	<20061013212202.GG28620@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061013212202.GG28620@localdomain>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

> Strange, node 0 appears to be in the middle of node 1.

Its an odd setup and may be a firmware issue but Ive seen it a number of
times on POWER5 boxes.

Anton
