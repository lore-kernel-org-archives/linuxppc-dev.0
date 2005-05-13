Return-Path: <Marco.Schramel@go.bartec.de>
Received: from mail.bartec.de (mail.bartec.de [217.5.168.170])
	by ozlabs.org (Postfix) with SMTP id 5914B679F2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 May 2005 22:38:35 +1000 (EST)
From: Marco Schramel <Schramel.Linux@go.bartec.de>
To: "PPC_LINUX" <linuxppc-embedded@ozlabs.org>
Date: Fri, 13 May 2005 14:33:23 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200505131433.23307.Schramel.Linux@go.bartec.de>
Subject: insmod problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

we use a custom mpc8270 system. Everything works fine.
Now i have to handle some float values in a device driver. If i insert the compiled module my target prints out 

insmod: unresolved symbol __addsf3
insmod: unresolved symbol __floatsisf

Are there any missing libraries ?

Any other ideas?

Best regards

Marco


-- 
---------
Marco Schramel
