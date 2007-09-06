Return-Path: <eha@doredevelopment.dk>
Received: from bq8.dotserv.com (bq8.dotserv.com [193.201.35.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3C9B6DDF3B
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 00:29:07 +1000 (EST)
Received: from bq8.dotserv.com (localhost [127.0.0.1])
	by bq8.dotserv.com (8.13.1/8.13.1) with ESMTP id l86ENnrK032228
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Sep 2007 16:23:50 +0200
To: linuxppc-dev@ozlabs.org
Subject: Configuring for UPM on MPC82xx using new device binding from Scott
MIME-Version: 1.0
Date: Thu, 6 Sep 2007 16:23:49 +0200
From: Esben Haabendal <eha@doredevelopment.dk>
Message-ID: <b0c1bc04d7f1f36bd546cd46ea1e035a@127.0.0.1>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi

Is it possible to configure chipselect to use UPM A and UPM B in an MPC8270 chip using the new CPM device bindings patches from Scott?

I need to pass in the 3 bits for MS (machine select to the relevant MRx register).

Best regards,
Esben Haabendal
