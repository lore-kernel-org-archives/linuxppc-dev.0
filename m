Return-Path: <indianirav@yahoo.com>
Received: from web43120.mail.sp1.yahoo.com (web43120.mail.sp1.yahoo.com
	[216.252.121.20]) by ozlabs.org (Postfix) with SMTP id 83B0DDDD0E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Feb 2007 00:07:55 +1100 (EST)
Date: Tue, 20 Feb 2007 05:07:53 -0800 (PST)
From: patel nirav <indianirav@yahoo.com>
Subject: cross compile RTAI for powerpc- whether the given procedure is
	correct?
To: linux ppc <linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-50797979-1171976873=:36087"
Message-ID: <587267.36087.qm@web43120.mail.sp1.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-50797979-1171976873=:36087
Content-Type: multipart/alternative; boundary="0-51372228-1171976873=:36087"

--0-51372228-1171976873=:36087
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit



Note: forwarded message attached.

Nirav J Patel
M.Tech(CSE),
Nirma University,
Ahmedabad-382481.
9925138959
 	
---------------------------------
Everyone is raving about the all-new Yahoo! Mail beta.
--0-51372228-1171976873=:36087
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<br><br>Note: forwarded message attached.<BR><BR>Nirav J Patel<br>M.Tech(CSE),<br>Nirma University,<br>Ahmedabad-382481.<br>9925138959<p>&#32;
	



<hr size=1>Everyone is raving about <a href="http://us.rd.yahoo.com/evt=42297/*http://advision.webevents.yahoo.com/mailbeta">the all-new Yahoo! Mail beta.</a>
--0-51372228-1171976873=:36087--

--0-50797979-1171976873=:36087
Content-Type: message/rfc822
Content-Transfer-Encoding: 8bit

X-Apparently-To: indianirav@yahoo.com via 216.252.121.18; Sun, 18 Feb 2007 22:42:47 -0800
X-Originating-IP: [128.218.64.140]
Authentication-Results: mta313.mail.mud.yahoo.com  from=rtai.org; domainkeys=fail (bad syntax)
Received: from 128.218.64.140  (EHLO comedi.org) (128.218.64.140)
  by mta313.mail.mud.yahoo.com with SMTP; Sun, 18 Feb 2007 22:42:06 -0800
Received: from localhost ([127.0.0.1] helo=comedi.ucsf.edu)
	by comedi.org with esmtp (Exim 3.35 #1 (Debian))
	id 1HJ2Cp-0004xC-00; Sun, 18 Feb 2007 22:40:59 -0800
Received: from mail by comedi.org with spam-scanned (Exim 3.35 #1 (Debian))
	id 1HJ29b-0004wP-00
	for <rtai@rtai.org>; Sun, 18 Feb 2007 22:37:45 -0800
Received: from web43121.mail.sp1.yahoo.com ([216.252.121.21])
	by comedi.org with smtp (Exim 3.35 #1 (Debian))
	id 1HJ29b-0004wL-00
	for <rtai@rtai.org>; Sun, 18 Feb 2007 22:37:39 -0800
Received: (qmail 97186 invoked by uid 60001); 19 Feb 2007 06:37:09 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=4g67G9J/FsUTGzduRfpsuFHLPPTevRmb1kuCDR4F4qgu4LPrr3ucHIfQn3SlN3WlcHpcA2sITiK+IRVj8RbZj9URxRTme0scre8b9wjwmEHuThwjWmaUHGO/qc7Clt0JgVAhe5Yzsy7PiFTNvkrWfW17IYLPrWds2aqGueSDuSM=;
X-YMail-OSG: clOkKsEVM1nXWLHAk2PEPH_BqckOInBkHdk4Bl9tUbXwZ9WLMAgKXh7OUavG8NBDm.INM7NV_4hPrcBPbedDZUsjCLraBhcE4bzTCuwOjue2tCdHvDSgX.00RTi13PGCG0G6Zc_WOFZR_OMxxaRV0ZM-
Received: from [203.77.201.73] by web43121.mail.sp1.yahoo.com via HTTP; Sun, 18 Feb 2007 22:37:08 PST
From: patel nirav <indianirav@yahoo.com>
Subject: cross compile RTAI for powerpc- whether the given procedure is correct?
To: rtai@rtai.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-514235993-1171867028=:97001"
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on comedi.org
X-Spam-Status: No, score=-2.3 required=4.0 tests=AWL,BAYES_00,HTML_50_60,
	HTML_MESSAGE,HTML_TITLE_EMPTY,RCVD_IN_SORBS_WEB autolearn=no
	version=3.0.4
X-Spam-Level: 
Sender: rtai-admin@rtai.org
Errors-To: rtai-admin@rtai.org
X-BeenThere: rtai@rtai.org
X-Mailman-Version: 2.0.11
Precedence: bulk
List-Help: <mailto:rtai-request@rtai.org?subject=help>
List-Post: <mailto:rtai@rtai.org>
List-Subscribe: <https://mail.rtai.org/cgi-bin/mailman/listinfo/rtai>,
	<mailto:rtai-request@rtai.org?subject=subscribe>
List-Id: RTAI discussion <rtai.rtai.org>
List-Unsubscribe: <https://mail.rtai.org/cgi-bin/mailman/listinfo/rtai>,
	<mailto:rtai-request@rtai.org?subject=unsubscribe>
List-Archive: <https://mail.rtai.org/pipermail/rtai/>
Date: Sun, 18 Feb 2007 22:37:08 -0800 (PST)
Content-Length: 1144

--0-514235993-1171867028=:97001
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

                    Hello friends  
   I want to cross compile the RTAI for powerpc. so i follow the following steps.
 
 
 
   Install crosstool for the powerpc  in /opt/crosstool
  
   Then i download 2.4.22 kernel and  apply patch
  
      patch no.1 :   linuxppc-2.4.22.patch < i download from the kernel.org>
   
      patch no.2 :   patch-2.4.22-adeos-r8  < i download from   http://cvs.gna.org/cvsweb/stromboli/patches/   >
   3. then i go to kernel source   directory and run make ARCH=ppc xconfig
   4. then make ARCH=ppc   CROSS_COMPILE=powerpc-604-linux-gnu- dep bzImage
   5. i found vmlinux image in my kernel   source directory
   
   then my question is whether this   vmlinux image is RTAI enabled image and that can be run on the   powerpc?    
  
 
 

Nirav J Patel
M.Tech(CSE),
Nirma University,
Ahmedabad-382481.
9925138959
 
---------------------------------
Bored stiff? Loosen up...
Download and play hundreds of games for free on Yahoo! Games.
--0-514235993-1171867028=:97001
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

    <meta http-equiv="CONTENT-TYPE" content="text/html; charset=utf-8"><title></title><meta name="GENERATOR" content="OpenOffice.org 2.0  (Linux)"><meta name="CREATED" content="20070219;11235300"><meta name="CHANGED" content="20070219;11363800">          <style>  <!--   @page { size: 8.5in 11in; margin: 0.79in }   P { margin-bottom: 0.08in }  -->  </style>  <div style="margin-bottom: 0in;">Hello friends  </div> <div style="margin-bottom: 0in;">  I want to cross compile the RTAI for powerpc. so i follow the following steps.</div> <div style="margin-bottom: 0in;"><br> </div> <ol><li><div style="margin-bottom: 0in;">Install crosstool for the powerpc  in /opt/crosstool</div>  </li><li><div style="margin-bottom: 0in;">Then i download 2.4.22 kernel and  apply patch</div>  <ol><li><div style="margin-bottom: 0in;">patch no.1 :   linuxppc-2.4.22.patch &lt; i download from the kernel.org&gt;</div>   </li><li><div style="margin-bottom: 0in;">patch no.2 :   patch-2.4.22-adeos-r8  &lt;
 i download from   <a href="http://cvs.gna.org/cvsweb/stromboli/patches/">http://cvs.gna.org/cvsweb/stromboli/patches/</a>   &gt;</div>   <div style="margin-bottom: 0in;">3. then i go to kernel source   directory and run make ARCH=ppc xconfig</div>   <div style="margin-bottom: 0in;">4. then make ARCH=ppc   CROSS_COMPILE=powerpc-604-linux-gnu- dep bzImage</div>   <div style="margin-bottom: 0in;">5. i found vmlinux image in my kernel   source directory</div>   <div style="margin-bottom: 0in;"></div>   <div style="margin-bottom: 0in;">then my question is whether this   vmlinux image is RTAI enabled image and that can be run on the   powerpc?    </div>  </li></ol> </li></ol> <BR><BR>Nirav J Patel<br>M.Tech(CSE),<br>Nirma University,<br>Ahmedabad-382481.<br>9925138959<p>&#32;

<hr size=1><a href="http://us.rd.yahoo.com/evt=49935/*http://games.yahoo.com">Bored stiff?</a> Loosen up...<br><a href="http://us.rd.yahoo.com/evt=49935/*http://games.yahoo.com">Download and play hundreds of games for free</a> on Yahoo! Games.
--0-514235993-1171867028=:97001--

_______________________________________________
RTAI mailing list
RTAI@rtai.org
https://mail.rtai.org/cgi-bin/mailman/listinfo/rtai

--0-50797979-1171976873=:36087--
