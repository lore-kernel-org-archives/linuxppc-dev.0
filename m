Return-Path: <jagannathanjay@aim.com>
Received: from imo-d06.mx.aol.com (imo-d06.mx.aol.com [205.188.157.38])
	by ozlabs.org (Postfix) with ESMTP id 3793B67BE2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Jul 2006 15:55:47 +1000 (EST)
Received: from jagannathanjay@aim.com
	by imo-d06.mx.aol.com (mail_out_v38_r7.5.) id 5.53d.5b61d180 (57871)
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Jul 2006 01:55:41 -0400 (EDT)
Date: Sat, 22 Jul 2006 01:55:41 -0400
From: jagannathanjay@aim.com
Message-Id: <8C87B6A995C6521-1C74-11273@FWM-M25.sysops.aol.com>
Subject: Reg. virtual address space in embedded linux
Content-Type: multipart/mixed;
	boundary="--------MailBlocks_8C87B6A995C6521_1C74_121D2_FWM-M25.sysops.aol.com"
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


----------MailBlocks_8C87B6A995C6521_1C74_121D2_FWM-M25.sysops.aol.com
Content-Type: multipart/alternative;
 boundary="--------MailBlocks_8C87B6A995C6521_1C74_121D3_FWM-M25.sysops.aol.com"



----------MailBlocks_8C87B6A995C6521_1C74_121D3_FWM-M25.sysops.aol.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

 Hi all
 
 We are porting third party driver code from vxworks to Embedded linux in MPC 8260 under a evaluation platform from Embedded Planet in linux kernel space.
 
  The first step we carried out was reading the chip id and we were able to read the chip id correctly.   For reading the chip id we used the routine ChipReadMemory in the attached text and we were able to retrive the chip id successfully.   Subsequently when we write and read from Chip Specific Control Status registers ,it didn't work.   I checked the manual and the Chip Specific Control Status registers have RW access.   Any inputs on how to check if the write we made to virtual address succeeds?   Is there a way to dump the linux virtual address and examine the write we made ?
 
 Regards
 Jay
  
   
________________________________________________________________________
Check Out the new free AIM(R) Mail -- 2 GB of storage and industry-leading spam and email virus protection.

----------MailBlocks_8C87B6A995C6521_1C74_121D3_FWM-M25.sysops.aol.com
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: 7bit

<HTML><BODY>
<div>Hi all<br>


<div><span class="406521009-18072006"><font face="Tahoma" size="2"><br>
We are porting 
third party driver code from vxworks to Embedded 
linux in MPC 8260 under a evaluation platform from Embedded Planet in linux kernel space.<br>
<br>
</font></span>
<div><span class="406521009-18072006"><font face="Tahoma" size="2">The first step we 
carried out was reading the chip id and we were able to read the chip id 
correctly.</font></span></div>


<div><span class="406521009-18072006"></span>&nbsp;</div>


<div><span class="406521009-18072006"><font face="Tahoma" size="2">For reading the 
chip id we used the routine ChipReadMemory in the attached text&nbsp;and we were able 
to retrive the chip id successfully.</font></span></div>


<div><span class="406521009-18072006"></span>&nbsp;</div>


<div><span class="406521009-18072006"><font face="Tahoma" size="2">Subsequently when 
we write and read from&nbsp;Chip Specific Control Status registers ,it didn't 
work.</font></span></div>


<div><span class="406521009-18072006"></span>&nbsp;</div>


<div><span class="406521009-18072006"><font face="Tahoma" size="2">I checked the 
manual and the Chip Specific Control Status registers have RW 
access.</font></span></div>


<div><span class="406521009-18072006"></span>&nbsp;</div>


<div><span class="406521009-18072006"><font face="Tahoma" size="2">Any inputs on how 
to check if the write we made to virtual address succeeds?</font></span></div>


<div><span class="406521009-18072006"></span>&nbsp;</div>


<div><span class="406521009-18072006"><font face="Tahoma" size="2">Is there a way to 
dump the linux virtual address and examine&nbsp;the write we 
made&nbsp;?<br>
<br>
Regards<br>
Jay<br>
</font></span></div>
<br>
</div>
&nbsp;</div>

<div class="AOLPromoFooter">
<hr style="margin-top:10px;" />
<a href="http://pr.atwola.com/promoclk/100122638x1081283466x1074645346/aol?redir=http%3A%2F%2Fwww%2Eaim%2Ecom%2Ffun%2Fmail%2F" target="_blank"><b>Check Out the new free AIM(R) Mail</b></a> -- 2 GB of storage and industry-leading spam and email virus protection.<br />
</div>

</BODY></HTML>

----------MailBlocks_8C87B6A995C6521_1C74_121D3_FWM-M25.sysops.aol.com--

----------MailBlocks_8C87B6A995C6521_1C74_121D2_FWM-M25.sysops.aol.com
Content-Type: text/plain; name="RWroutines.txt"
Content-Disposition: attachment; filename="RWroutines.txt"
Content-Transfer-Encoding: base64

aW50IENoaXBSZWFkTWVtb3J5KHVuc2lnbmVkIGludCBhcmdfcGh5c19hZGRyLHVuc2lnbmVk
IGludCAqbWVtVmFsdWUpDQp7DQogIHZvaWQgICp2aXJ0X2FkZHIgPSBOVUxMOw0KICB1bnNp
Z25lZCBpbnQgcGh5c19hZGRyID0gMDsNCg0KICBwaHlzX2FkZHIgPSAgREVWSUNFX0JBU0Vf
QUREUkVTUyArIGFyZ19waHlzX2FkZHI7DQogIHZpcnRfYWRkciA9IGlvcmVtYXAocGh5c19h
ZGRyLCA0KTsNCiAgaWYodmlydF9hZGRyID09IE5VTEwpDQogIHsNCiAgICAgcHJpbnRrKCJD
aGlwUmVhZE1lbW9yeTogdW5hYmxlIHRvIHBlcmZvcm0gaW9yZW1hcCBcbiIpOw0KICAgICBy
ZXR1cm4gLTE7DQogIH0NCiAgKm1lbVZhbHVlICA9IHJlYWRsKHZpcnRfYWRkcik7DQogICAg
aW91bm1hcCh2aXJ0X2FkZHIpOw0KICAgIHJldHVybiAwOw0KfQ0KDQoNCmludCBDaGlwV3Jp
dGVNZW1vcnkodW5zaWduZWQgaW50IGFyZ19waHlzX2FkZHIsIHVuc2lnbmVkIGludCBhcmdf
dmFsKQ0Kew0KICB2b2lkICAqdmlydF9hZGRyID0gTlVMTDsNCiAgdW5zaWduZWQgaW50IHBo
eXNfYWRkciA9IDA7DQogIHBoeXNfYWRkciA9ICBERVZJQ0VfQkFTRV9BRERSRVNTICsgYXJn
X3BoeXNfYWRkcjsNCiAgdmlydF9hZGRyID0gaW9yZW1hcChwaHlzX2FkZHIsIDQpOw0KICBp
Zih2aXJ0X2FkZHIgPT0gTlVMTCkNCiAgew0KICAgICBwcmludGsoIkNoaXBXcml0ZU1lbW9y
eSA6IHVuYWJsZSB0byBwZXJmb3JtIGlvcmVtYXAgXG4iKTsNCiAgICAgcmV0dXJuIC0xOw0K
ICB9DQogIHdyaXRlbChhcmdfdmFsLHZpcnRfYWRkcik7DQogIGlvdW5tYXAodmlydF9hZGRy
KTsNCiAgIHJldHVybiAwOw0KfQ0K

----------MailBlocks_8C87B6A995C6521_1C74_121D2_FWM-M25.sysops.aol.com--
