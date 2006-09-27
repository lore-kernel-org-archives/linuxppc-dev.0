Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org,
 cbe-oss-dev@ozlabs.org
Subject: RFC/slightly offtopic: Automatic patchwork status updates
Date: Wed, 27 Sep 2006 15:28:48 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200609271528.49260.jk@ozlabs.org>
Cc: Troy Rollo <troy@corvu.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

For some time now, we've been running patchwork on the linuxppc and 
cbe-oss-dev lists. For those who haven't seen it, it collects and 
tracks patches posted to the lists, and shows them here:

  http://patchwork.ozlabs.org/linuxppc
and
  http://patchwork.ozlabs.org/cbe-oss-dev

However, the patch 'state' (eg, accepted, rejected, debug only, changes 
requested) doesn't get updated very often, as it can be an unnecessary 
burden on the maintainers.

All this information is available from the actual upstream tree itself, 
so essentially patchwork *should* be able to just mirror the state.

So, I'd like to get a bit of discussion on how we can get this (or at 
least most of it!) done automatically. For instance, can we come up 
with a scheme that can detect if a patch has made it into paulus' tree 
with some reasonable error rate?

If we can get something sketched up, I'll implement & integrate into 
patchwork. Seeing as this is an own-time project for me though, there 
will probably be a little latency in the process ;)

Cheers,


Jeremy

PS. do we need to create a separate patchwork list and move discussion 
there?
