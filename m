Subject: 405 I2C
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
To: Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Cc: Armin Kuster <akuster@mvista.com>,
	andrew may <acmay@acmay.homeip.net>
Content-Type: text/plain
Date: 21 May 2002 17:30:53 +0200
Message-Id: <1021995053.7265.22.camel@swb11>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


How would you feel about merging the i2c-adap-ibm_ocp.c
andi2c-algo-ibm_ocp.c into one file. This way it's possible to build the
i2c drivers as a module.


Also I have a problem when accessing a device that is not present. The
bus ends up in busy state an no other action can be taken. I solved the
problem for me here by simply removing the test in iix_xfer but a proper
solution has to be discussed. I have not tried Andrew's new iic_xfer is
it going to be merged ??


--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
