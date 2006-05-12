Return-Path: <monika_borikar@yahoo.com>
Received: from web30302.mail.mud.yahoo.com (web30302.mail.mud.yahoo.com
	[68.142.200.95]) by ozlabs.org (Postfix) with SMTP id 327AC679EA
	for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2006 16:51:18 +1000 (EST)
Message-ID: <20060512064437.17666.qmail@web30302.mail.mud.yahoo.com>
Date: Thu, 11 May 2006 23:44:37 -0700 (PDT)
From: Monika Borikar <monika_borikar@yahoo.com>
Subject: DMA problem on PPC 74xx
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1221658401-1147416277=:15869"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-1221658401-1147416277=:15869
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello All,
 
 I am working on PPC 74xx processor which uses Marvell mv64360 host bridge. On PPC linux-2.6.12.5 (with EV64360 patch ) is running, with CONFIG_NOT_COHERENT_CACHE=y option in .config file.
 
 I have a pci device which has to do DMA transfer from PPC memory. This pci device is DMA master for all dma transactions. The device driver on PPC allocates memory using pci_alloc_consistent & write the data to this allocated memory. Address of this allocated memory is given to device using which device is supposed to do read/write using dma mechanism.
 
 Looks like dma transfer is not happening. I found few mails which talks about some problem with caching. Can anybody guide me if there is any such issue & how to solve that?
 
 Thanks
 -Monika
 
 
		
---------------------------------
New Yahoo! Messenger with Voice. Call regular phones from your PC and save big.
--0-1221658401-1147416277=:15869
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello All,<br> <br> I am working on PPC 74xx processor which uses Marvell mv64360 host bridge. On PPC linux-2.6.12.5 (with EV64360 patch ) is running, with CONFIG_NOT_COHERENT_CACHE=y option in .config file.<br> <br> I have a pci device which has to do DMA transfer from PPC memory. This pci device is DMA master for all dma transactions. The device driver on PPC allocates memory using pci_alloc_consistent &amp; write the data to this allocated memory. Address of this allocated memory is given to device using which device is supposed to do read/write using dma mechanism.<br> <br> Looks like dma transfer is not happening. I found few mails which talks about some problem with caching. Can anybody guide me if there is any such issue &amp; how to solve that?<br> <br> Thanks<br> -Monika<br> <br> <p>
		<hr size=1>New Yahoo! Messenger with Voice. <a href="http://us.rd.yahoo.com/mail_us/taglines/postman5/*http://us.rd.yahoo.com/evt=39666/*http://messenger.yahoo.com">Call regular phones from your PC</a> and save big.
--0-1221658401-1147416277=:15869--
