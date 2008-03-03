Return-Path: <s104259@yahoo.it>
Date: Mon, 3 Mar 2008 14:18:19 +0100 (CET)
From: Angelo <s104259@yahoo.it>
Subject: i2s driver
To: Linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1481141879-1204550299=:99199"
Message-ID: <931295.99199.qm@web23104.mail.ird.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1481141879-1204550299=:99199
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Thanks for answer.

>I can also send you some GPL'd code that works.
>It is extremely bad commented (:-p) and probably not useful
> (it's not an ALSA driver itself, but it uses the DMA to
> copy data to the PSC - I2S mode) but it works. 

It is a great idea; i can use it to start. 
You can send it via mail..

> But this code is based on 2.6.16 kernel.

I'm using 2.6.22 kernel version.

I just enabled in lite5200b.dts:

//PSC3 in CODEC mode example  //asimmini
i2s@2400 {  // PSC3
 device_type = "sound";
 compatible = "mpc5200b-psc-i2s";//not 5200 compatible
 cell-index = <2>;
 reg = <2400 100>;
 interrupts = <2 3 0>;
 interrupt-parent = <&mpc5200_pic>;
};

..and added in lite5200.c, in function mpc52xx_psc_functions
...
struct mpc52xx_psc_func mpc52xx_psc_functions[]= {
{       .id     = 2,  
        .func   = "i2s",
},
...
thanks for help.




       
---------------------------------

---------------------------------
L'email della prossima generazione? Puoi averla con la nuova Yahoo! Mail
--0-1481141879-1204550299=:99199
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Thanks for answer.<br><br>&gt;I can also send you some GPL'd code that works.<span style="font-family: monospace;"><br></span>&gt;It is extremely bad commented (:-p) and probably not useful<span style="font-family: monospace;"><br></span>&gt; (it's not an ALSA driver itself, but it uses the DMA to<span style="font-family: monospace;"><br></span>&gt; copy data to the PSC - I2S mode) but it works. <br><pre>It is a great idea; i can use it to start. <br>You can send it via mail..<br><br>&gt; But this code is based on 2.6.16 kernel.<br><br>I'm using 2.6.22 kernel version.<span style="font-family: arial;"><br><br>I just enabled in lite5200b.dts:<br><br>//PSC3 in CODEC mode example  //asimmini<br>i2s@2400 {  // PSC3<br> device_type = "sound";<br> compatible = "mpc5200b-psc-i2s";//not 5200 compatible<br> cell-index = &lt;2&gt;;<br> reg = &lt;2400 100&gt;;<br> interrupts = &lt;2 3 0&gt;;<br> interrupt-parent = &lt;&amp;mpc5200_pic&gt;;<br>};<br><br>..and added in lite5200.c, in
 function </span><span style="font-family: arial;">mpc52xx_psc_functions</span><br><span style="font-family: arial;">...<br>struct mpc52xx_psc_func mpc52xx_psc_functions[]= {<br>{       .id     = 2,  <br>        .func   = "i2s",<br>},<br>...<br>thanks for help.<br></span></pre><BR><BR><p>&#32;



      <hr size=1><font face="Arial" size="2"><hr size=1><font face="Arial" size="2">L'email della prossima generazione? Puoi averla con la <a href="http://us.rd.yahoo.com/mail/it/taglines/hotmail/nowyoucan/nextgen/*http://it.docs.yahoo.com/nowyoucan.html">nuova Yahoo! Mail</a></font>
--0-1481141879-1204550299=:99199--
