Return-Path: <joro-2013@t-online.de>
Received: from mailout06.t-online.de (mailout06.t-online.de [194.25.134.19])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vFFXD46WBzDqBZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 22:49:32 +1100 (AEDT)
Received: from fwd20.aul.t-online.de (fwd20.aul.t-online.de [172.20.26.140])
 by mailout06.t-online.de (Postfix) with SMTP id 86F8341D807D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 12:42:04 +0100 (CET)
Subject: Timekeeping oddities on MacMini G4s
References: <1316061184.389961.1486121485729@mail.yahoo.com>
To: linuxppc-dev@lists.ozlabs.org
From: Jochen Rollwagen <joro-2013@t-online.de>
Message-ID: <58946C84.5090402@t-online.de>
Date: Fri, 3 Feb 2017 12:41:56 +0100
MIME-Version: 1.0
In-Reply-To: <1316061184.389961.1486121485729@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello There,

here's the output on a mac mini g4 1,5GhZ running OS X 10.4 which hadn't 
booted that OS in ages :-)



jochen-rollwagens-mac-mini:~ jochenrollwagen$ ntpq -c "rv 0 frequency" localhost
status=c011 sync_alarm, sync_unspec, 1 event, event_restart,
frequency=0.000


If there's anything else i can contribute, let me know.

Cheers

Jochen
