Message-ID: <3C67D5EE.70008@elsoft.ch>
Date: Mon, 11 Feb 2002 15:32:14 +0100
From: "David =?ISO-8859-15?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: [PATCH] Several patches against linuxppc_devel-2.4.18-pre9
Content-Type: multipart/mixed;
 boundary="------------070008040707050007050701"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------070008040707050007050701
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hello

The attached patch fixes the following issues:

    - drivers/net/ibm_ocp_enet.c
       wrong prototypes + initialisation in debug code

    - drivers/net/ibm_ocp_enet.h
       missing prototypes for [get|set]_maltxdeir()
       missing prototypes for [get|set]_maltxctp1r()

    - drivers/net/ibm_ocp_phy.c
       workaround for MII-PHY communication bug reported by Andrew May

    - arch/ppc/mm/fault.c
       missing type cast

    - arch/ppc/mm/cachemap.c
       missing prototype for map_page() (added mmu_decl.h)
       2 missing type casts

Dave


--------------070008040707050007050701
Content-Type: application/octet-stream;
 name="linuxppc.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="linuxppc.patch.bz2"

QlpoOTFBWSZTWY1elmEAApv/gGEwBAB7f///f//e5L/v//5QBhj2WyypVyBqQCkgZIQT0ptN
R5Mk8k0PUDT1NA0yAaAAAaaAGoQBo0mSegCMJpkDAAAmEwmA1GEEiIino0U8pk8SeTSMRoAA
AAZAAAA5hNGRoaGQwjQyGmjQAYjJkAwgGARSEE0YhGp6aDJRskzSeKAaNNBgh6nqepoZGSyg
c1DaHyGIOTlqREAyYbY2OJjzrjYN1rUqSxjQ5mVO8bU86f4zRQhssihNWNo4+GP81ZNYlGFy
NSyEzBOmVnnd3WqCvs12FMyOvGOkSlaSJSfVI4VXdFUBNN49T66BowL9R7ONsLzPjWA4gCAq
VWqq1kUKlVUECK9DTTSERERLJFwjJAfaxXhDFOgLnPnGPhtlnyyZ0+gnItQJfMUQt87xjIsQ
4cmyOvj+Hs/st5zwJfVZzlCprTrTC3nBk7KpAR4i6ekDgMIi5FElAwLcFpJLo8bsBlaYCgEG
O9Rgla8zKW0AND7AK4AvDN0rbJHgk6uAYNdTuqZkF/bUaEwoMc0siqBMJbqxQKzlq6CiEvvF
s0D7qOEJGXDcpEi91jwZIvI1VmuGOlGBL8AzbtsiSgwfJw4l3DIEDX6YIIE0T2gaUpKQ9Mkm
hA4GkrdEZzACXJQw1Zys6DxuzgnLqpEEiKYj8wkJoQxNmBKhGURir/YhkDIa24Nm7Rr57u2V
GV5G5WFA9YtaDmGdvXFlRrpdFKoEmJrHzYmhpWnmCzt9pYJPpN6UaoheQuGUo2OhW8iSlHIW
K28vQSX8zFIXmwIY75CsBtMkbDIpFKU4riInHjipVY87gNrma651svITTAso20dJhZBbU133
xks4MxkDlWwFAu31wb3NefkdGyr3GVfEwDbYrmFcvz0LsiGDAJCeBPiNY+UQohRD09x2nZn5
vXb3R+/Z4Tus7im+wVYAeHE4bbDghFIzvdEAWB1GGEhdCfBqyQPLPqhcrijqQZBSJtAwXVKu
2g6ZwZtoxEPkUjhl7k+dBYEMBQGdPQeWhynuMDsia+Yr+0inhGafOHCdp4zq+VbTKgdJmVu+
9C3M5jqtCDOYjZQsgiwmeeHItAz94rRzNKo06ALUCyFf8yz0FBhfQTgjMXFYfwSOi5lRexvA
0lpr30Oa0ofiDRdRqH0wPnyZUis9BvMveGGQmt0gOrUERkAuqc5S1CNiNKi5JXE0IhIBtCSZ
yTWy02GueX1F5maLm2Ey8RJYZVlKsbHaKc2ZJm7JqIxqjhtH+GFfBQqK9Y/QBvpdMqT/WM6Q
mAlVQwca40ysfqUi0zmEgewyLmAXIMjrSmi9JahpWw2NttttwiMAWgZEmliDjGkx6lo3NCnS
VWpaSuc/cZiW/TEMpEBYu1GiGVJMbg5Bgg3jUGYmBJhel2i5NEOR0oWLaZNi3q6tJxVJZyvw
o5L7wLZK8TNTjylzqJGvF2ntM5BUJaLtoZNmkw/Px05YcYSCCA4pIGdvMN9dlVu4d8ZhqYUu
biYBiugyoSzF5w4GVWFeg3VMzngqMbBl23jfmz7U2AEe+C/xlXeckqQcSSG9C9ZJalYwWAJM
lLEA4iRQ4KIWEl5FetK2acLw/Hm8mU39DCSZMSwSRahe68dzuj+iKi8FmsXCywq2EZhQLfqU
UmAi8z5EuZq4n7dvXExSjnqr1cJkAzB38biYys1DCGIBYQhXLGGTlRuNvvs3JWY8hSCs0oZy
m3n0AWHFzLMznFF5GTLFmnXru6fHCcW4Dl2bAxWuJWnDffKYCaDahCuKwzPhbGwUOrQlQkkF
aGktRLQyF1QDFaENa23MZSSWWo3ZVNPi7/HUjU/DQ3t4BuHh6NBXqOTlptMxPvLwEVASZLAk
LI5rSShn0BELUAbwOonItOCxMCP/F3JFOFCQjV6WYQ==
--------------070008040707050007050701--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
