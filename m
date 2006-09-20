Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3358C67B67
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Sep 2006 03:15:02 +1000 (EST)
Date: Wed, 20 Sep 2006 10:14:50 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Sachin Rane <SRane@alphion.com>
Subject: Re: Couldn't find reference for i2c_smbus functinos
Message-ID: <20060920171450.GA30655@gate.ebshome.net>
References: <8584FDC94AFF7640B17B8A89B23B19B34F6573@sbsserver.AlphionCorp.local>
	<8584FDC94AFF7640B17B8A89B23B19B34F6576@sbsserver.AlphionCorp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8584FDC94AFF7640B17B8A89B23B19B34F6576@sbsserver.AlphionCorp.local>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Sep 20, 2006 at 11:07:52AM -0400, Sachin Rane wrote:
> Hi,
>  
> Following text is from "/usr/local/linux/Doumentation/dev-interface":
> ----------------------------------------------------------------------------------------------------------------------------------
> You can do SMBus level transactions (see documentation file smbus-protocol
> for details) through the following functions:
>   __s32 i2c_smbus_write_quick(int file, __u8 value);
>   __s32 i2c_smbus_read_byte(int file);
>   __s32 i2c_smbus_write_byte(int file, __u8 value);
>   __s32 i2c_smbus_read_byte_data(int file, __u8 command);
>   __s32 i2c_smbus_write_byte_data(int file, __u8 command, __u8 value);
>   __s32 i2c_smbus_read_word_data(int file, __u8 command);
>   __s32 i2c_smbus_write_word_data(int file, __u8 command, __u16 value);
>   __s32 i2c_smbus_process_call(int file, __u8 command, __u16 value);
>   __s32 i2c_smbus_read_block_data(int file, __u8 command, __u8 *values);
>   __s32 i2c_smbus_write_block_data(int file, __u8 command, __u8 length,
>                                    __u8 *values);
> ---------------------------------------------------------------------------------------
>  
> I searched in the 2.6.13 version of Timesys and Suse linux, but I 
> didn't find definition or declaration in file 
> '/usr/include/linux/i2c-dev.h' and '/usr/include/linux/i2c.h'.

Please, look for this functions in the kernel source tree, not in 
user-space headers.

-- 
Eugene
