Return-Path: <smitha.vanga@wipro.com>
Received: from wipro-blr-out02.wipro.com (wipro-blr-out02.wipro.com
 [203.91.198.75])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 497D9B6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2011 15:15:21 +1100 (EST)
From: <smitha.vanga@wipro.com>
To: <scottwood@freescale.com>
Subject: I2c-cpm drievr not working
Date: Fri, 14 Oct 2011 04:14:55 +0000
Message-ID: <40631E9A2581F14BA60888C87A76A1FE015B09@HYD-MKD-MBX4.wipro.com>
In-Reply-To: <4E8C9741.9010401@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 
Hi Scott,

I am using the i2c-cpm driver to read and write to a LM75 sensor. The 
int i2c_master_send(struct i2c_client *client,const char *buf ,int count) fu=
nction is not successful.
Could you let me know what may be the issue. Below are the traces.

DS75_DRIVER : Open
DS75_DRIVER : Device Open Successful!
DS75_DRIVER  : ioctl TEMP_READ cmd 1
In i2c_master_send enter-------
In i2c_master_send enter [2]-------
In i2c_master_send msg.addr=3Dc031
In i2c_master_send 1 client->addr =3D0
In i2c_master_send 2
In i2c_master_send 3
In i2c_master_send 4
--- enter i2c_transfer
i2c_transfer_entry
*********** cpm_i2c_xfer
***********cpm_i2c_parse_message
***********cpm_i2c_check_message
*********** else
 rv =3D1
In i2c_master_send 5
 i2c_master_recv client.addr=3D0
--- enter i2c_transfer
i2c_transfer_entry
*********** cpm_i2c_xfer
***********cpm_i2c_parse_message
i2c_adapter i2c-0: I2C transfer: timeout
*********** cpm_i2c_xfer out_err
***********cpm_i2c_force_close
 rv =3Dffffff87
DS75_DRIVER  : Error reading from I2C 

Regards,
Smitha
Please do not print this email unless it is absolutely necessary. 

The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and may=
 contain proprietary, confidential or privileged information. If you are not=
 the intended recipient, you should not disseminate, distribute or copy this=
 e-mail. Please notify the sender immediately and destroy all copies of this=
 message and any attachments. 

WARNING: Computer viruses can be transmitted via email. The recipient should=
 check this email and any attachments for the presence of viruses. The compa=
ny accepts no liability for any damage caused by any virus transmitted by th=
is email. 

www.wipro.com
