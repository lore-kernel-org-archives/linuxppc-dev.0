Return-Path: <dibacco@libero.it>
Received: from cp-out1.libero.it (cp-out1.libero.it [212.52.84.101])
	by ozlabs.org (Postfix) with ESMTP id AEC1AB7082
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Sep 2009 18:15:05 +1000 (EST)
Message-ID: <30044818.1469311253607282485.JavaMail.root@wmail36>
Date: Tue, 22 Sep 2009 10:14:42 +0200 (CEST)
From: "dibacco@libero.it" <dibacco@libero.it>
To: <Daniele.Bosi@mta.it>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: R: High load average  but low cpu (xenomai can be the explanation?)
MIME-Version: 1.0
Content-Type: text/plain;charset="UTF-8"
Reply-To: "dibacco@libero.it" <dibacco@libero.it>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is an AgentX subagent, it does a lot of things like accessing the hardware, 
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
bounces+daniele.bosi=mta.it@lists.ozlabs.org [mailto:linuxppc-dev-
bounces+daniele.bosi=mta.it@lists.ozlabs.org] Per conto di dibacco@libero.it

>Oggetto: High load average but low cpu (xenomai can be the explanation?)
>

>Hi,
>
>I have an MPC880 @133MHz. If I look into the load (with uptime) I get

>values around 3.0 but my CPU is always under 5 percent (top). How could I

>explain this? I'm using linux 2.6.19 with xenomai but no xenomai application 
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
