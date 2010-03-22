Return-Path: <liu.yaojin@zte.com.cn>
Received: from mx7.zte.com.cn (mx7.zte.com.cn [202.103.147.169])
	by ozlabs.org (Postfix) with ESMTP id 30852B7CFA
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Mar 2010 11:48:16 +1100 (EST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
	by mse2.zte.com.cn with ESMTP id o2M0beNF012492
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Mar 2010 08:37:40 +0800 (CST)
	(envelope-from liu.yaojin@zte.com.cn)
To: linuxppc-dev@lists.ozlabs.org
Subject: could you help me the GPIO problem on MPC8323?
MIME-Version: 1.0
Message-ID: <OFB2D6905F.1103328E-ON482576EE.00030001-482576EE.000388CF@zte.com.cn>
From: liu.yaojin@zte.com.cn
Date: Mon, 22 Mar 2010 08:33:40 +0800
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hi,all:

i saw peter's mpc8xxx_gpio.c in kernel 2.6.31. it seems that file can only 
be used on 831x and others, but not mpc8323. my platform is mpc8323, how 
can i use the GPIO?
i also found "QE GPIO Support" and "Support for simple, memory-mapped GPIO 
controllers" selection, would that be helpful for me? how can i use?

thanks, best regards.

evan.


--------------------------------------------------------
ZTE Information Security Notice: The information contained in this mail is solely property of the sender's organization. This mail communication is confidential. Recipients named above are obligated to maintain secrecy and are not permitted to disclose the contents of this communication to others.
This email and any files transmitted with it are confidential and intended solely for the use of the individual or entity to whom they are addressed. If you have received this email in error please notify the originator of the message. Any views expressed in this message are those of the individual sender.
This message has been scanned for viruses and Spam by ZTE Anti-Spam system.
