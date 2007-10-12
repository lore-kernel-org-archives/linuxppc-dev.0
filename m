Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id C6DD3DDE05
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Oct 2007 04:30:16 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1144189wag
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 11:30:15 -0700 (PDT)
Message-ID: <fa686aa40710121130p7ec957bar471c2e8245bd162b@mail.gmail.com>
Date: Fri, 12 Oct 2007 12:30:14 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Mackerras" <paulus@samba.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	"Sylvain Munaut" <tnt@246tnt.com>
Subject: mpc52xx bestcomm patches.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paulus, how do you feel about merging these changes?

This is Sylvain's series of bestcomm patches.

http://patchwork.ozlabs.org/linuxppc/patch?id=13488
http://patchwork.ozlabs.org/linuxppc/patch?id=13489
http://patchwork.ozlabs.org/linuxppc/patch?id=13490
http://patchwork.ozlabs.org/linuxppc/patch?id=13491
http://patchwork.ozlabs.org/linuxppc/patch?id=13492
http://patchwork.ozlabs.org/linuxppc/patch?id=13493
http://patchwork.ozlabs.org/linuxppc/patch?id=13494

There are still a few minor issues to be resolved, but Sylvain is
suffering from a severe lack of time and this series has been stalled
for a long time because of it.  Domen and others have been working on
drivers which use bestcomm, but they can neither get their drivers
included nor address the issues in this series because of it.

Personally, I think it will be better to just merge it now and allow
others to address the remaining comments.  It's not like this is a
change to an old device that could be risky.

/me thinks about somebody saying at some time "The perfect is the
enemy of the good"  :-)

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
