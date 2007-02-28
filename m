Return-Path: <indianirav@yahoo.com>
Received: from web43137.mail.sp1.yahoo.com (web43137.mail.sp1.yahoo.com
	[216.252.121.67]) by ozlabs.org (Postfix) with SMTP id 00C03DDE2E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 05:01:54 +1100 (EST)
Date: Wed, 28 Feb 2007 10:01:52 -0800 (PST)
From: patel nirav <indianirav@yahoo.com>
Subject: how to boot powerpc with image ?
To: linux ppc <linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1227979334-1172685712=:91067"
Message-ID: <977777.91067.qm@web43137.mail.sp1.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1227979334-1172685712=:91067
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

                    hi all
   
 I have powerpc 604 and MVME 3604 and I want to run the linux 2.4.18 on that platform.
 
 
 So i follow the following instruction to compile 2.4.18 for powerpc604
 
 
 
   Install crosstool for the  powerpc604 (from kegel.com) in /opt/crosstool
  
   Then i download 2.4.18 kernel.   
  3. then i go to kernel source   directory and run make ARCH=ppc xconfig
4. then make ARCH=ppc CROSS_COMPILE=powerpc-604-linux-gnu- dep bzImage
5. i found following  images in my   kernel source directory    
i.e   <home>/linux/2.4.18/arch/ppc/boot/images

                  vmlinux
       
                  zImage.chrp
       
                  vmlinux.coff
       
                  zImage.pmac
       
                  zImage.prep






          
  Now What is the step to boot with this images ?
 which is the main image to boot ?
 whether it will give me command prompt?
 I am using tornado for interfacing with powerpc (PPC604)
 
 Regards 
 Nirav
 
 
  
 
---------------------------------
Have a burning question? Go to Yahoo! Answers and get answers from real people who know.
--0-1227979334-1172685712=:91067
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

    <meta http-equiv="CONTENT-TYPE" content="text/html; charset=utf-8"><title></title><meta name="GENERATOR" content="OpenOffice.org 1.9.104  (Linux)"><meta name="CREATED" content="20070228;19153100"><meta name="CHANGED" content="20070228;19243600">          <style>  <!--   @page { size: 8.5in 11in; margin: 0.79in }   P { margin-bottom: 0.08in }  -->  </style>  <div style="margin-bottom: 0in;">hi all</div> <div style="margin-bottom: 0in;">  </div> <div style="margin-bottom: 0in;">I have powerpc 604 and MVME 3604 and I want to run the linux 2.4.18 on that platform.</div> <div style="margin-bottom: 0in;"><br> </div> <div style="margin-bottom: 0in;">So i follow the following instruction to compile 2.4.18 for powerpc604</div> <div style="margin-bottom: 0in;"><br> </div> <ol><li><div style="margin-bottom: 0in;">Install crosstool for the  powerpc604 (from kegel.com) in /opt/crosstool</div>  </li><li><div style="margin-bottom: 0in;">Then i download 2.4.18 kernel.   </div> 
 <ol><div style="margin-bottom: 0in;">3. then i go to kernel source   directory and run make ARCH=ppc xconfig</div><div style="margin-bottom: 0in;">4. then make ARCH=ppc CROSS_COMPILE=powerpc-604-linux-gnu- dep bzImage</div><div style="margin-bottom: 0in;">5. i found following  images in my   kernel source directory    </div><div style="margin-bottom: 0in;">i.e   &lt;home&gt;/linux/2.4.18/arch/ppc/boot/images</div><ol><ol><ol><ol><li><div style="margin-bottom: 0in;">vmlinux</div>       </li><li><div style="margin-bottom: 0in;">zImage.chrp</div>       </li><li><div style="margin-bottom: 0in;">vmlinux.coff</div>       </li><li><div style="margin-bottom: 0in;">zImage.pmac</div>       </li><li><div style="margin-bottom: 0in;">zImage.prep</div></li></ol></ol></ol></ol></ol></li></ol>    <meta http-equiv="CONTENT-TYPE" content="text/html; charset=utf-8"><title></title><meta name="GENERATOR" content="OpenOffice.org 1.9.104  (Linux)"><meta name="CREATED"
 content="20070228;19153100"><meta name="CHANGED" content="20070228;19243600">    <style>  <!--   @page { size: 8.5in 11in; margin: 0.79in }   P { margin-bottom </style><br> &nbsp;Now What is the step to boot with this images ?<br> which is the main image to boot ?<br> whether it will give me command prompt?<br> I am using tornado for interfacing with powerpc (PPC604)<br> <br> Regards <br> Nirav<br> <br> <br>  <p>&#32;

<hr size=1>Have a burning question? Go to <a href="http://answers.yahoo.com/;_ylc=X3oDMTFvbGNhMGE3BF9TAzM5NjU0NTEwOARfcwMzOTY1NDUxMDMEc2VjA21haWxfdGFnbGluZQRzbGsDbWFpbF90YWcx">Yahoo! Answers</a> and get answers from real people who know.
--0-1227979334-1172685712=:91067--
