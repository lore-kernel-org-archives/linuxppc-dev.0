Return-Path: <Daniele.Bosi@mta.it>
Received: from cluster-a.mailcontrol.com (cluster-a.mailcontrol.com
	[85.115.52.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.mailcontrol.com",
	Issuer "DigiCert Global CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7DE60B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Sep 2009 19:34:20 +1000 (EST)
Received: from rly11a.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly11a.srv.mailcontrol.com (MailControl) with ESMTP id
	n8M9Xgm0023496
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2009 10:34:03 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly11a.srv.mailcontrol.com (MailControl) id n8M9XP5f022461
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2009 10:33:25 +0100
From: Bosi Daniele <Daniele.Bosi@mta.it>
To: "'dibacco@libero.it'" <dibacco@libero.it>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>
Date: Tue, 22 Sep 2009 11:32:43 +0200
Subject: R: High load average  but low cpu (xenomai can be the explanation?)
Message-ID: <531B6536C9F737458807DF75064873C8303DD7D7DC@mta-digimail.MTA.INT>
In-Reply-To: <30044818.1469311253607282485.JavaMail.root@wmail36>
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

I suggest you to take a look at the meaning of the data showed by "/proc/lo=
adavg".

See:
http://www.luci.org/luci-discuss/200210/msg00055.html

for more details.

In my opinion your loadavg of 3.0 means only that in your application there=
 is an average of 3 task waiting for running on the CPU. This in general do=
esn't mean that the CPU load must be 100 %.

Maybe there should be some scheduler issues.

If you take a look into your app sources maybe you can know more about what=
 happens.


-----Messaggio originale-----
Da: dibacco@libero.it [mailto:dibacco@libero.it]
Inviato: marted=EC 22 settembre 2009 10.15
A: Bosi Daniele; linuxppc-dev@lists.ozlabs.org
Oggetto: R: High load average but low cpu (xenomai can be the explanation?)

It is an AgentX subagent, it does a lot of things like accessing the hardwa=
re,
handling messages from the main snmp agent received from an unix socket,
writing files on jffs2 partition, polling hardware for alarms.
If I kill it,
the load goes down. Anyway the subagent only takes 2-3% of the CPU..

Thank
you,
Antonio.



>Da: Daniele.Bosi@mta.it
>
>Can you give us some more details
about your app?
>Is it multithread or single process?
>What do the process do?

>
>Bye Daniele
>
>
>
>-----Messaggio originale-----
>Da: linuxppc-dev-
bounces+daniele.bosi=3Dmta.it@lists.ozlabs.org [mailto:linuxppc-dev-
bounces+daniele.bosi=3Dmta.it@lists.ozlabs.org] Per conto di dibacco@libero=
.it

>Oggetto: High load average but low cpu (xenomai can be the explanation?)
>

>Hi,
>
>I have an MPC880 @133MHz. If I look into the load (with uptime) I get

>values around 3.0 but my CPU is always under 5 percent (top). How could I

>explain this? I'm using linux 2.6.19 with xenomai but no xenomai applicati=
on
is
>running at all. I have a cramfs on a nor flash. What could be the problem?
If I
>kill the process I developed the average load goes down.
>
>Thank you,

>Adi
>_______________________________________________
>Linuxppc-dev mailing
list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-
dev
>_______________________________________________
>Linuxppc-dev mailing list

>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev

>
