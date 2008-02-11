Return-Path: <therealshowman@yahoo.ca>
Received: from web32704.mail.mud.yahoo.com (web32704.mail.mud.yahoo.com
	[68.142.207.248]) by ozlabs.org (Postfix) with SMTP id A4141DDE9A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Feb 2008 08:26:44 +1100 (EST)
Date: Mon, 11 Feb 2008 16:26:43 -0500 (EST)
From: NM <therealshowman@yahoo.ca>
Subject: Re: MPC8272 FCC2 MDIO on Port D and FS_ENET
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <399508.89089.qm@web32709.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1439029003-1202765203=:35949"
Message-ID: <235903.35949.qm@web32704.mail.mud.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1439029003-1202765203=:35949
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

My problem is solved now after probing the lines, MDC was not showing any activity.
So, after explicitly setting the PD23 (MDC) to : OUTPUT/GPIO in mpc8272_ads_pins and  it worked in 

I'd previously thought about that, but I was sure that this was being taken care of, but now that I'm thinking of it, I'm questioning my belief.  
I think in the fs_enet/mii-bitbang.c: mdio_dir(..) it is supposed to take care of this. But why I had to explictly set it initially beats me. I wonder how this works in standard distribution.

thanks


       
---------------------------------
Be smarter than spam. See how smart SpamGuard is at giving junk email the boot with the All-new Yahoo! Mail  
--0-1439029003-1202765203=:35949
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

My problem is solved now after probing the lines, MDC was not showing any activity.<br>So, after explicitly setting the PD23 (MDC) to : OUTPUT/GPIO in mpc8272_ads_pins and&nbsp; it worked in <br><br>I'd previously thought about that, but I was sure that this was being taken care of, but now that I'm thinking of it, I'm questioning my belief.&nbsp; <br>I think in the fs_enet/mii-bitbang.c: mdio_dir(..) it is supposed to take care of this. But why I had to explictly set it initially beats me. I wonder how this works in standard distribution.<br><br>thanks<br><br><p>&#32;
      <hr size=1>Be smarter than spam. See how smart SpamGuard is at giving junk email the boot with the <a href="http://ca.promos.yahoo.com/newmail/overview2/"><b>All-new Yahoo! Mail </b></a> 

--0-1439029003-1202765203=:35949--
