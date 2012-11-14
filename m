Return-Path: <anton@samba.org>
Date: Wed, 14 Nov 2012 13:57:02 +1100
From: Anton Blanchard <anton@samba.org>
To: jslaby@suse.cz, benh@kernel.crashing.org, paulus@samba.org,
 gregkh@linuxfoundation.org, alan@linux.intel.com
Subject: HVC console breakage
Message-ID: <20121114135702.7b332dd7@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

Commit bdb498c20040 (TTY: hvc_console, add tty install) breaks HVC on
ppc64. It looks a bit like a refcounting issue and we end up releasing
the tty. I haven't had a change to look closer yet.

Anton
