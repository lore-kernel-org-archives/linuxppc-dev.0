Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.226])
	by ozlabs.org (Postfix) with ESMTP id E5F76DDFED
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 00:15:49 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so3053287rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Sep 2008 07:15:47 -0700 (PDT)
Message-ID: <319b0ac50809030715h1a03a606jacddd400019f4483@mail.gmail.com>
Date: Wed, 3 Sep 2008 16:15:47 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: irq
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_28971_15903953.1220451347718"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_28971_15903953.1220451347718
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I am trying to register a function writh IRQ :

static irqreturn_t uart_test (int irq , void *dev_id)
{
    printk("/!\\ Interruption : tx_empty\n");
       return IRQ_HANDLED;
}

    req=request_irq(0x18,uart_test,NULL,"uart_test",NULL);
    printk("Initialisation IRQ UART : %d \n", req);

When I boot linux ppc, the req value is -38.
What is wrong ?

------=_Part_28971_15903953.1220451347718
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br>
<br>
I am trying to register a function writh IRQ :<br>
&nbsp;<br>
static irqreturn_t uart_test (int irq , void *dev_id)<br>
{<br>
&nbsp;&nbsp;&nbsp; printk(&quot;/!\\ Interruption : tx_empty\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return IRQ_HANDLED;<br>
}<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; req=request_irq(0x18,uart_test,NULL,&quot;uart_test&quot;,NULL);<br>
&nbsp;&nbsp;&nbsp; printk(&quot;Initialisation IRQ UART : %d \n&quot;, req);&nbsp;&nbsp;&nbsp; <br>
<br>
When I boot linux ppc, the req value is -38.<br>
What is wrong ?<br>

------=_Part_28971_15903953.1220451347718--
