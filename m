Return-Path: <anton@ozlabs.org>
Date: Sun, 21 Mar 2010 00:10:44 +1100
From: Anton Blanchard <anton@samba.org>
To: amit.shah@redhat.com, alan@lxorguk.ukuu.org.uk, rusty@rustcorp.com.au,
	gregkh@suse.de
Subject: hvc_console breakage
Message-ID: <20100320131044.GC24064@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

I haven't tracked down why, but e74d098c66543d0731de62eb747ccd5b636a6f4c
(hvc_console: Fix race between hvc_close and hvc_remove) is causing my PowerPC
box to hang during boot, right when init starts.

Anton
