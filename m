To: kingseft@samsung.co.kr
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: =?EUC-KR?Q?(=C0=E7=C0=FC=BC=DB)_Question_for_module_compile_for_p?= =?EUC-KR?Q?pc?= 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_18217759760"
Date: Fri, 11 May 2001 02:12:26 +0200
Message-Id: <20010511001231.32BCB2814D@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multipart MIME message.

--==_Exmh_18217759760
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 11 May 2001 08:57:55 +0900."
             <H00002af04d228f3@MHS>
Content-Transfer-Encoding: 8bit

In message <H00002af04d228f3@MHS> you wrote:
>
>  I'd like to display target board's LED information(for examples, On/Off) to WebPage.
>  I use GoAhead WebServer and also I added all related programs to my ramdisk.
>  I'd like to know how to send target board's LED info into webpage.

Since you're using our sources anyway: see the  "status  LED"  driver
(drivers/char/status_led.c  and  include/asm-ppc/status_led.h). It is
trivial to adapt to other configurations. [But  please  note  that  I
have a fix for a race condition pending - give me a day or two to put
2.4.4 on the FTP server].

Then use a little tool like the attached one to read the  LED  status
from a CGI script...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Our missions are peaceful -- not for conquest.  When we do battle, it
is only because we have no choice.
	-- Kirk, "The Squire of Gothos", stardate 2124.5


--==_Exmh_18217759760
Content-Type: application/x-gzip ; name="status_led.c.gz"
Content-Description: status_led.c.gz
Content-Disposition: attachment; filename="status_led.c.gz"
Content-Transfer-Encoding: base64

H4sIANpshDoAA7VVbVPaQBD+nPyKLa2dBKOA/QbSqYVomVrsEBydWoeJyQVuTC5McqBO5b93
95JrQWCmtZYvZN+fvWdvr1Y1oQpWx4ZOOn3I+Hgi4aBer5O26/YvwUsjeednDFwx5oKxjIsx
GS/SOBr7YgxdJm4duAs/hEzc74eMjEdxDCpXDhnLWTZn4T7p6Uf/b7q+ZE14o74HbM5znopC
rpnmay6CeBYyOIwCIeP9yfslVS5Dnq6pYn7zRPeQ13garEWjOpe+XNfKhynLV9UxF7P72tTP
/GTFUKEMs3wUY1eTimkGEz+DapCEwk9YS8shthWQSN48gHnKQ5jl/piBRd82mriQZuJzARZ+
gZ+NAweK6CoKc9v8YRpkicJW8THF809RMI2yHLRBue7ukpJHYFEWaLehYZuGoepZWMowjQKQ
DkDV3h756jgrCtGWTpmwCk8HzkaD7sXAtuEQ6jYgFgPrZ2kGpQflNTImZxl24F72hqPjo97p
+cAlwwLz5ndcBpMCk0oQ+DmDRhPDqKQiCLCwA97waHjunbrd0Yk7dOBt0ehS5U2lt9bG4hiA
oyqxSsVTdAEmB55DRTloZLoOlVDg9hrN35Gp+C4Kf8O4yZh/29JuUF92i6INfiGL/Fksl/xu
cKJu8f4AFp/ATghJDqmoYXhJLGZxVBKjBIb3o4G30YYafPr2tAA1qQUF6kAfbC6zIJnSsc+v
GtcOYCMVm4ZCH+bW0/fo9AtxRPJZf5mDjSRsZ0EhXACLEdtmWFH0XFzHx/8TmGLqmdA+nvb6
n3v9kxfCp+LLvWFvpP3dVtp1G6+ojV95ijTlgLXxdsqUF0EH1zZOHE4azhvNXatMXPoe4lIp
L6Me6S9c8MSPy/ml+6XGmgYZLEpRw2x/cFm3nu5Xd9A76zrwAgvhnxj862qaIr0GzBUWaTsW
zwAEcYokIiR6EVZzeuedjut5aFisvCOmzkQPRKTJwHcQQSLtytqEnRzKnX+FawYegRbNI6ih
0IRdlyunfE4IGrvncq2nhfkTw5mQ/CoIAAA=

--==_Exmh_18217759760--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
