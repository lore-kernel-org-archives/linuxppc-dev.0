Return-Path: <r_wehbi@yahoo.fr>
Received: from web26704.mail.ukl.yahoo.com (web26704.mail.ukl.yahoo.com
	[217.146.176.67]) by ozlabs.org (Postfix) with SMTP id 42B00DDE45
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jan 2008 00:32:15 +1100 (EST)
Date: Thu, 17 Jan 2008 14:25:34 +0100 (CET)
From: WEHBI Rami <r_wehbi@yahoo.fr>
Subject: error: array type has incomplete element type
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-559914106-1200576334=:76187"
Message-ID: <154802.76187.qm@web26704.mail.ukl.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-559914106-1200576334=:76187
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all,
  
 I am trying to compile a kernel for the ppc405 embedded on the virtex 4 and I am obtaining the compiling errors listed below(at the end of this mail).
  
 my compiler is the crosstool  latest one. 
  
 I tried to compile each the  following kernel versions :
 2.6.23.8
  2.6.17
  
 with the following versions of  gcc and glibc of the crosscompiler
 gcc-4.0.2-glibc-2.3.5
 gcc-4.1.0-glibc-2.3.6
 gcc-4.1.1-glibc-2.3.6
  
 the result is always the same  (array type has incomplete element type)
  
 moreover I searched all the  files and I replaced 
             (struct ocp_def  core_ocp[])        with  (struct ocp_def core_ocp[2]) 
         because my architectur  contains only one UART, the result is always the same (same  error).
  
  
 any help is  appreciated,
  
  
  arch/ppc/syslib/virtex_devices.c:23: error: array type has incomplete element  type
 arch/ppc/syslib/virtex_devices.c:25: error: field name not in record or union  initializer
 arch/ppc/syslib/virtex_devices.c:25: error: (near initialization for  'core_ocp')
 arch/ppc/syslib/virtex_devices.c:26: error: field name not in record or union  initializer
 arch/ppc/syslib/virtex_devices.c:26: error: (near initialization for  'core_ocp')
 arch/ppc/syslib/virtex_devices.c:27: error: field name not in record or union  initializer
  arch/ppc/syslib/virtex_devices.c:27: error: (near initialization for  'core_ocp')
 arch/ppc/syslib/virtex_devices.c:28: error: field name not in record or union  initializer
 arch/ppc/syslib/virtex_devices.c:28: error: (near initialization for  'core_ocp')
 arch/ppc/syslib/virtex_devices.c:29: error: field name not in record or union  initializer
 arch/ppc/syslib/virtex_devices.c:29: error: (near initialization for  'core_ocp')
 arch/ppc/syslib/virtex_devices.c:30: error: field name not in record or union  initializer
 arch/ppc/syslib/virtex_devices.c:30: error: (near initialization for  'core_ocp')
 arch/ppc/syslib/virtex_devices.c:30: error: 'OCP_CPM_NA' undeclared here (not  in a function)
 arch/ppc/syslib/virtex_devices.c:63: error: field name not in record or union  initializer
 arch/ppc/syslib/virtex_devices.c:63: error: (near initialization for   'core_ocp')


Rami



             
---------------------------------
 Ne gardez plus qu'une seule adresse mail ! Copiez vos mails vers Yahoo! Mail 
--0-559914106-1200576334=:76187
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div><span class="846124916-08012008"><font size="2">Hi all,</font></span></div> <div><span class="846124916-08012008"></span>&nbsp;</div> <div><span class="846124916-08012008"><font size="2">I am trying to compile a&nbsp;kernel for the ppc405 embedded on the virtex 4 and I am obtaining the compiling errors listed below(at the end of this mail).</font></span></div> <div><span class="846124916-08012008"></span>&nbsp;</div> <div><span class="846124916-08012008"><font size="2">my compiler is the crosstool  latest one. </font></span></div> <div><span class="846124916-08012008"></span>&nbsp;</div> <div><span class="846124916-08012008"><font size="2">I tried to compile each the  following kernel versions :</font></span></div> <div><span class="846124916-08012008"><font size="2">2.6.23.8</font></span></div>  <div><span class="846124916-08012008"><font size="2">2.6.17</font></span></div> <div><span class="846124916-08012008"></span>&nbsp;</div> <div><span
 class="846124916-08012008"><font size="2">with the following versions of  gcc and glibc of the crosscompiler</font></span></div> <div><span class="846124916-08012008"><font size="2">gcc-4.0.2-glibc-2.3.5</font></span></div> <div><span class="846124916-08012008"><span class="846124916-08012008"><font size="2">gcc-4.1.0-glibc-2.3.6</font></span></span></div> <div><span class="846124916-08012008"><span class="846124916-08012008"><span class="846124916-08012008"><font size="2">gcc-4.1.1-glibc-2.3.6</font></span></span></span></div> <div><span class="846124916-08012008"></span>&nbsp;</div> <div><span class="846124916-08012008"><font size="2">the result is always the same  (array type has incomplete element type)</font></span></div> <div><span class="846124916-08012008"></span>&nbsp;</div> <div><span class="846124916-08012008"><font size="2">moreover I searched all the  files and I replaced </font></span></div> <div><span class="846124916-08012008"><font
 size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct ocp_def  core_ocp[])&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; with&nbsp; (struct ocp_def core_ocp[2])&nbsp;</font></span></div> <div><span class="846124916-08012008">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font size="2">because my architectur  contains only one UART, the result is always the same (same  error).</font></span></div> <div><span class="846124916-08012008"></span>&nbsp;</div> <div><span class="846124916-08012008"></span>&nbsp;</div> <div><span class="846124916-08012008"><font size="2">any help is  appreciated,</font></span></div> <div><span class="846124916-08012008"></span>&nbsp;</div><span class="846124916-08012008"></span> <div><span class="846124916-08012008"></span>&nbsp;</div> <div><span class="846124916-08012008"><font size="2"> <div>arch/ppc/syslib/virtex_devices.c:23: error: array type has incomplete element  type</div> <div>arch/ppc/syslib/virtex_devices.c:25:
 error: field name not in record or union  initializer</div> <div>arch/ppc/syslib/virtex_devices.c:25: error: (near initialization for  'core_ocp')</div> <div>arch/ppc/syslib/virtex_devices.c:26: error: field name not in record or union  initializer</div> <div>arch/ppc/syslib/virtex_devices.c:26: error: (near initialization for  'core_ocp')</div> <div>arch/ppc/syslib/virtex_devices.c:27: error: field name not in record or union  initializer</div>  <div>arch/ppc/syslib/virtex_devices.c:27: error: (near initialization for  'core_ocp')</div> <div>arch/ppc/syslib/virtex_devices.c:28: error: field name not in record or union  initializer</div> <div>arch/ppc/syslib/virtex_devices.c:28: error: (near initialization for  'core_ocp')</div> <div>arch/ppc/syslib/virtex_devices.c:29: error: field name not in record or union  initializer</div> <div>arch/ppc/syslib/virtex_devices.c:29: error: (near initialization for  'core_ocp')</div> <div>arch/ppc/syslib/virtex_devices.c:30: error:
 field name not in record or union  initializer</div> <div>arch/ppc/syslib/virtex_devices.c:30: error: (near initialization for  'core_ocp')</div> <div>arch/ppc/syslib/virtex_devices.c:30: error: 'OCP_CPM_NA' undeclared here (not  in a function)</div> <div>arch/ppc/syslib/virtex_devices.c:63: error: field name not in record or union  initializer</div> <div>arch/ppc/syslib/virtex_devices.c:63: error: (near initialization for   'core_ocp')<br><br><br>Rami<br></div></font></span></div><p>&#32;
      

      <hr size="1"> 
Ne gardez plus qu'une seule adresse mail ! <a href="http://fr.rd.yahoo.com/mail/mail_taglines/trueswitch/*http://www.trueswitch.com/yahoo-fr/">Copiez vos mails</a> vers Yahoo! Mail 
--0-559914106-1200576334=:76187--
