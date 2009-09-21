Return-Path: <Daniele.Bosi@mta.it>
Received: from cluster-a.mailcontrol.com (cluster-a.mailcontrol.com
	[85.115.52.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.mailcontrol.com",
	Issuer "DigiCert Global CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0D1DCB7B68
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Sep 2009 02:22:18 +1000 (EST)
Received: from rly14a.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly14a.srv.mailcontrol.com (MailControl) with ESMTP id
	n8LFZpbw024985
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2009 16:35:58 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly14a.srv.mailcontrol.com (MailControl) id n8LFZgUu024325
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2009 16:35:42 +0100
From: Bosi Daniele <Daniele.Bosi@mta.it>
To: "'dibacco@libero.it'" <dibacco@libero.it>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>
Date: Mon, 21 Sep 2009 17:35:09 +0200
Subject: R: High load average  but low cpu (xenomai can be the explanation?)
Message-ID: <531B6536C9F737458807DF75064873C8303DD7D7D7@mta-digimail.MTA.INT>
In-Reply-To: <17851044.2911671253545985517.JavaMail.root@wmail27>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Can you give us some more details about your app?
Is it multithread or single process?
What do the process do?

Bye Daniele



-----Messaggio originale-----
Da: linuxppc-dev-bounces+daniele.bosi=3Dmta.it@lists.ozlabs.org [mailto:lin=
uxppc-dev-bounces+daniele.bosi=3Dmta.it@lists.ozlabs.org] Per conto di diba=
cco@libero.it
Inviato: luned=EC 21 settembre 2009 17.13
A: linuxppc-dev@lists.ozlabs.org
Oggetto: High load average but low cpu (xenomai can be the explanation?)

Hi,

I have an MPC880 @133MHz. If I look into the load (with uptime) I get
values around 3.0 but my CPU is always under 5 percent (top). How could I
explain this? I'm using linux 2.6.19 with xenomai but no xenomai applicatio=
n is
running at all. I have a cramfs on a nor flash. What could be the problem? =
If I
kill the process I developed the average load goes down.

Thank you,
Adi
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
