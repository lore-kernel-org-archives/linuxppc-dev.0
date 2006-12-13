Return-Path: <henk.stegeman@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.229])
	by ozlabs.org (Postfix) with ESMTP id 7034F67B61
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Dec 2006 07:59:22 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 71so160994wri
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Dec 2006 12:59:19 -0800 (PST)
Message-ID: <ae4f76fd0612131259h6df7b20fi68561d7878f49483@mail.gmail.com>
Date: Wed, 13 Dec 2006 21:59:18 +0100
From: "Henk Stegeman" <henk.stegeman@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Best location for call to spi_register_board_info () on PPC (MPC5200)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_119890_10051454.1166043558769"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_119890_10051454.1166043558769
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm working on an SPI procol driver on the MPC52XX.
I spend some time in trying to find the best location for calling
spi_register_board_info () (which basically registers the relations between
protocol drivers and the SPI chip selects).

I wish to call this function from my copy of the
arch/ppc/platforms/Lite5200.c file  since these relations are
board-specific, however I found that placing the call in any of these
functions (eg. lite5200_setup_arch) results in an -ENOMEM from the
spi_register_board_info () call.

Now I'm calling spi_register_board_info () from the spi controller driver
which is soo ugly.

Thanks in advance,

Henk.

------=_Part_119890_10051454.1166043558769
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm working on an SPI procol driver on the MPC52XX.<br>I spend some time in trying to find the best location for calling spi_register_board_info () (which basically registers the relations between protocol drivers and the SPI chip selects).
<br><br>I wish to call this function from my copy of the arch/ppc/platforms/Lite5200.c file&nbsp; since these relations are board-specific, however I found that placing the call in any of these functions (eg. lite5200_setup_arch) results in an -ENOMEM from the spi_register_board_info () call. 
<br><br>Now I'm calling spi_register_board_info () from the spi controller driver which is soo ugly.<br><br>Thanks in advance,<br><br>Henk.<br><br><br>

------=_Part_119890_10051454.1166043558769--
